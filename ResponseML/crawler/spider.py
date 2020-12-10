# Spider requirements
from newsapi import NewsApiClient
import time
from datetime import datetime
import requests
import bs4
from pdb import set_trace
import jsonlines
from utils import *
import eventlet
# eventlet.monkey_patch()

# Loading and preprocessing
import pickle 
import joblib
import pandas as pd
import re
import nltk
from nltk.corpus import stopwords
# nltk.download('stopwords')
from nltk.stem import PorterStemmer

# Model building
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.pipeline import Pipeline
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.feature_selection import SelectKBest, chi2
from sklearn.ensemble import RandomForestClassifier
import spacy

import warnings
warnings.filterwarnings('ignore')

# For DB
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firestore import RealNews

# Use a service account
cred = credentials.Certificate('../cred.json')
firebase_admin.initialize_app(cred)
DB = firestore.client()


class Spider:

    output = []
    
    def __init__(self):

        self.time_ = time.time()
        
        # Keep count of news being fetched from different sources
        self.count_api = 0
        self.count_dte = 0
        self.count_demo = 0
        self.final_count = 0

        # get news from API
        self.get_news_from_api()
        # get news from links
        self.get_news_from_links()
        relevant = self.filter_relevant()
        
        relevant = list(zip(self.output,relevant))
        relevant = list(filter(only_relevant,relevant))

        # get disaster type
        disasters = self.get_disaster_type(relevant)
    
        self.ner_model =spacy.load('en_core_web_sm')
        disasters['temp'] = disasters['news'].apply(self.get_NER)
        disasters['date'] = pd.to_datetime(disasters['date'], format='%d %b %Y')
        disasters.sort_values(by=['date'],inplace=True,ascending=False)
        # write results
        self.send_to_db(disasters)

        # write logs
        self.get_logs()


    def get_news_from_api(self):

        # Init
        newsapi = NewsApiClient(api_key='76eb8da143df4bc586e05edaf8ad2335')

        # /v2/top-headlines
        top_headlines = newsapi.get_top_headlines(
                                                  category='health',
                                                  language='en',
                                                  country='in')
        
        # Extract news from the API
        for article in top_headlines['articles']:
            
            try:
                # Fetch all the fields
                date = article['publishedAt']
                title = article['title']
                desc = article['description']
                url = article['url']
                image = article['urlToImage']

                # clean the data 
                date = process_date(date,0)
                title = process_text(title)
                desc = process_text(desc)
                # store the data
                self.output.append([date,title,desc,url,image])
                self.count_api += 1

            except:
                # if any error continue
                continue

    
    def get_news_from_links(self):
        
        # CONSTANTS
        HEADERS = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36'}

        LINKS = [
                # index 0 == downtoearth.org
                'https://www.downtoearth.org.in/category/natural-disasters/news?page=1&per-page=25',
                # index 1 == demonews website
                'https://demo-news-site.netlify.app/'
                ]


        # Extract news from the links mentioned
        for i, link in enumerate(LINKS):
            
            # DownToEarth
            if i == 0:
                # Loop to paginate through downtoearth
                for i in range(1):
                    # Scraping Structure for downtoearth.org
                    sublink = link[:68] + str(i) + link[69:]
                    try:
                        r = requests.get(sublink, HEADERS, timeout=10)
                        soup = bs4.BeautifulSoup(r.content,'html.parser')
                        container = soup.find_all(class_='single-news-wrapper')

                        for div in container:
                            try:
                                a = div.find_all('a')
                                # get url
                                url = a[0]['href']
                                # get title and desciption
                                title, desc = a[2].find_all('p')
                                title, desc = title.text, desc.text
                                # get date
                                date = div.find_all(class_='pull-left content-date')
                                date = date[0].text
                                # get image
                                image = div.find('img')['src']

                                # clean the data 
                                date = process_date(date,1)
                                title = process_text(title)
                                desc = process_text(desc)


                                # store the data
                                self.output.append([date,title,desc,url,image])
                                self.count_dte += 1
                                
                            except:
                                print('Theres an error with Down_to_earth scraper')    
                    except:
                        print('https://www.downtoearth.org.in/category/natural-disasters TIMEOUT Error:')
            

            # DemoNews
            if i == 1:
                try: 
                    r = requests.get(link, HEADERS,timeout=10)
                    soup = bs4.BeautifulSoup(r.content,'html.parser')
                    container = soup.find_all(class_='news')
                    
                    for div in container:
                        title = div.find('h3').text
                        date = div.find('h6').text
                        desc = div.find('p').text
                        url = div.find('a')['href']
                        image = div.find('img')['src']

                        # clean the data 
                        date = process_date(date,2)
                        title = process_text(title)
                        desc = process_text(desc)

                        # store the data
                        self.output.append([date,title,desc,url,image])
                        self.count_demo += 1

                except:
                    print('https://demo-news-site.netlify.app/ TIMEOUT Error:')
                


    def filter_relevant(self):
        
        # seperate all the news in a list
        news = []
        for article in self.output:
            news.append(article[1])
        
        # load the pretrained models
        model_test=joblib.load("../ML/ML1 algo/model1.pkl")
        vectorizer = joblib.load("../ML/ML1 algo/vectorizer.pkl")
        
        # transform testing data into a document-term matrix (using existing vocabulary)
        tokenized_news = vectorizer.transform(news)
        tokenized_news.toarray()

        # prediction
        pred = model_test.predict(tokenized_news)
        return pred


    def get_disaster_type(self,news):
        model=joblib.load("../ML/ML2 algo/model_2.pkl")
        vectorizer = joblib.load("../ML/ML2 algo/vect_2.pkl")

        # Store relevant data in dataframe
        test_news = {
                'date':[],
                'news':[],
                'description':[],
                'url':[],
                'image':[],
                'type':[],
                'temp':[]
                }
        temp_news = [n for (n, rel) in news]
        for article in temp_news:
            test_news['date'].append(article[0])
            test_news['news'].append(article[1])
            test_news['description'].append(article[2])
            test_news['url'].append(article[3])
            test_news['image'].append(article[4])
            test_news['temp'].append(article[1])
            test_news['type'].append(1)



        test_news = pd.DataFrame(test_news)
        
        # clean and preprocess the data
        stemmer = PorterStemmer()
        words = stopwords.words("english")
        test_news['temp'] = test_news['temp'].apply(lambda x: " ".join([stemmer.stem(i) for i in re.sub("[^a-zA-Z]", " ", x).split() if i not in words]).lower())
        test_news.type = model.predict(test_news.temp)

        return test_news

    def get_NER(self,string):

        # set_trace()
        # model=joblib.load("../ML/ML2 algo/ner.pkl")
        text = self.ner_model(string)

        for w in text.ents:
            text = w.text
            label = w.label_
            if (w.label_ == 'GPE'):
                return text


    def send_to_db(self,df):
        news = DB.collection('RealNews').order_by("date",direction=firestore.Query.DESCENDING).limit(25).stream()

        last_article_dates = [n.to_dict()['headline'] for n in news] 
        
        for i in range(len(df)):
            date = df.iloc[i].date
            headline = df.iloc[i].news
            if headline in last_article_dates or date.date() != datetime.now().date():
                continue
            description = df.iloc[i].description
            distype = df.iloc[i]['type']
            url = df.iloc[i].url
            imageurl = df.iloc[i].image
            location = df.iloc[i].temp
            relnews = RealNews(date, headline, description, distype, url, imageurl,location)

            doc_ref = DB.collection(u'RealNews').add(relnews.to_dict())
            self.final_count += 1


##############################################################for writing to external file
# def write_data(self):

#         with jsonlines.open('data.jsonl','a') as f:
#             for article in self.output:
#                 one_article = {
#                             'date':article[0],
#                             'title':article[1],
#                             'description':article[2],
#                             'url':article[3],
#                             'image':article[4]
#                             }
#                 f.write(one_article)
#########################################################################################

    def get_logs(self):
        
        if self.final_count==0:
            logs = 'No new rows added'
        else:
            logs = str(self.final_count) +' rows added.'

        print(f'{datetime.fromtimestamp(self.time_)}: {logs}')

spider = Spider()
