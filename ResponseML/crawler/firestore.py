
#####################################Data class
class RealNews(object):

    def __init__(self, date, headline, description,distype, url="", imageurl="",location=""):
        self.date = date
        self.headline = headline
        self.description = description
        self.url = url
        self.distype = distype
        self.imageurl = imageurl
        self.location = location

    @staticmethod
    def from_dict(source):
        self.date = source['date']
        self.headline = source['headline']
        self.description = source['description']
        self.url = source['url']
        self.distype = source['distype']
        self.imageurl = source['imageurl']
        self.location = source['location']
    
    def to_dict(self):
        
        return {
                'date': self.date,
                'headline' : self.headline,
                'description' : self.description,
                'url' : self.url,
                'distype' : self.distype,
                'imageurl' : self.imageurl,
                'location' : self.location,
                }


    def __repr__(self):
        return(f"News( date: {self.date}, headline : {self.headline}, description : {self.description}, url : {self.url}, distype : {self.distype}, imageurl : {self.imageurl}, location : {self.location})")

#####################################write Data

# date = input('Enter date: ')
# headline = input('Enter headlines: ')
# description = input('Enter description: ')
# distype = input('Enter disaster type: ')
# url = input('Enter url: ')
# imageurl = input('Enter image url: ')
# location = input('Enter location: ')


