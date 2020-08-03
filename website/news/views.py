from django.shortcuts import render,redirect
from django.contrib import messages,auth
from django.core import serializers
from django.http import JsonResponse
import http.client
from .forms import SubscribeForm
import pandas as pd
import numpy as np
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore,auth
from urllib.parse import quote_plus
from django.core.mail import send_mail
import requests
import threading

from django.contrib.auth import login, authenticate
from .models import MinistryNews

cred = credentials.Certificate('news/disaster-alert-3f948-firebase-adminsdk-777fm-6f9d4a11b4.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

#Display-Database
doc_ref = db.collection(u'RealNews')
snapshot = doc_ref.get()
news = db.collection('RealNews').order_by('date',direction=firestore.Query.DESCENDING).limit(30).stream()
l2 = []
for n in news:
    l1 = []
    data = n.to_dict()
    date = data['date']
    headline = data['headline']
    image_url = data['imageurl']
    description = data['description']
    share_link = quote_plus(data['headline'])
    l1.append(date)
    l1.extend((headline,description,share_link,image_url))
    l2.append(l1)
k = pd.DataFrame(l2,columns=['date','headline','description','share_link','image_url'])

def homepage(request):
    #Ministry-news
    queryset = MinistryNews.objects.all().order_by('-date')
    print(queryset)
        #Real-time Updation
    callback_done = threading.Event()

    # Create a callback on_snapshot function to capture changes
    def on_snapshot(doc_snapshot, changes, read_time):
        for d in doc_snapshot:
            # print(d.to_dict())
            doc = d.to_dict()
            headline = doc['headline']
            description = doc['description']

            print(f'Received document snapshot: {headline}')
        
        
            

        #Retrieval of Users:- 
        doc_email = db.collection('Users').stream()
        for d in doc_email:
            email_send = []
            data = d.to_dict()
            email = data['email']               #Retrieval-of-email-ids
            contact = data['contact']
            email_send.append(email)            #appending-it-to-the-email-list
            
            #SENDING SMS TO EACH USER 
            url = "https://www.fast2sms.com/dev/bulk"
            message = headline
            if len(contact) > 10:
                number = contact[3:]
            else:
                number = contact
            payload = "sender_id=FSTSMS&message="+message+"&language=english&route=p&numbers="+number
            headers = {
            'authorization': "FWLraiHjfoSUGcBeJuOT9sQNCdPbgpw4EXI63yD720ntMA8K51WV1Kw5NTikXExzIA6y74vHJSpClFMb",
            'Content-Type': "application/x-www-form-urlencoded",
            'Cache-Control': "no-cache",
            }
            response = requests.request("POST", url, data=payload, headers=headers)
            print(response.text) 

        #SENDING EMAILS TO EACH USER
        send_mail(headline,description,'dsouza.kevin952@gmail.com',email_send,fail_silently=False)

        callback_done.set()
    doc_ref = db.collection(u'RealNews')

    # WATCHES DOCUMENT FOR ANY CHANGE IN DOCUMENTS
    doc_watch = doc_ref.on_snapshot(on_snapshot)

    message = ""
    #Subscribe-user
    if request.method == 'POST':
        email = request.POST.get('email')
        contact = request.POST.get('contact')
        data = {'name':request.POST.get('name'), 'email':email, 'contact':contact }
        form =  SubscribeForm(request.POST)
        
        if form.is_valid():
            doc = db.collection(u'Users').where(u'contact','==',contact).get()
            if doc:
                print(doc)
                message = 'Contact exists! Re-enter New Details!'

            else:
                message = "SUBSCRIPTION is completed!!"
                db.collection('Users').add(data)
        else:
            print('not valid')
            message = "INVALID INPUT DETAILS!!"
    else:
        form = SubscribeForm()
        context2 ={
        'form':form
        }

        context1 = dict(
                    data = k,
                    columns = ['date','headline','description','share_link'] 
                    )
    
        context3 = dict(
            mess = message
            )
    return render(request,'news/base.html',context={'context1':context1,'context2':context2,'context3':context3,'query':queryset})



#SOS - BUTTON for Ambulance
def Relief_help(request):

    if request.method == 'POST':
        name = request.POST['name']
        contact = request.POST['contact']
        hospital = request.POST['hospital']
        user_latitude = request.POST['lat']
        user_longitude = request.POST['lon']


        print(name)
        print(contact)
        print(hospital)
        print(user_longitude,user_longitude)
    
        url = "https://www.fast2sms.com/dev/bulk"
        message = 'Hi, I am '+name + 'I need help! My location is ('+user_latitude + ',' + user_longitude + ')'
        number = '9920238345'
        payload = "sender_id=FSTSMS&message="+message+"&language=english&route=p&numbers="+number
        headers = {
        'authorization': "FWLraiHjfoSUGcBeJuOT9sQNCdPbgpw4EXI63yD720ntMA8K51WV1Kw5NTikXExzIA6y74vHJSpClFMb",
        'Content-Type': "application/x-www-form-urlencoded",
        'Cache-Control': "no-cache",
        }
        response = requests.request("POST", url, data=payload, headers=headers)
        print(response.text) 

    return render(request, 'news/base.html')

#SOS - BUTTON For FIrst-Aid
def Relief_help2(request):

    if request.method == 'POST':
        name = request.POST['name']
        contact = request.POST['contact']
        ngo = request.POST['ngo']
        injury = request.POST['injury']
        user_latitude = request.POST['lat']
        user_longitude = request.POST['lon']


        print(name)
        print(contact)
        print(ngo)
        print(user_longitude,user_longitude) 

        url = "https://www.fast2sms.com/dev/bulk"
        message = 'Hi, I am '+name + 'I need help! My location is ('+user_latitude + ',' + user_longitude + ')'
        number = contact
        payload = "sender_id=FSTSMS&message="+message+"&language=english&route=p&numbers="+number
        headers = {
        'authorization': "FWLraiHjfoSUGcBeJuOT9sQNCdPbgpw4EXI63yD720ntMA8K51WV1Kw5NTikXExzIA6y74vHJSpClFMb",
        'Content-Type': "application/x-www-form-urlencoded",
        'Cache-Control': "no-cache",
        }
        response = requests.request("POST", url, data=payload, headers=headers)
        print(response.text) 

    return render(request, 'news/base.html')

def message(request):
    
    return render(request, 'news/base.html')


def test_email(request):
    doc_ref = db.collection(u'RealNews')
    snapshot = doc_ref.get()
    news = db.collection('RealNews').order_by('date',direction=firestore.Query.DESCENDING).limit(1).stream()
    for n in news:
        data = n.to_dict()

    title = data['headline']
    body = data['description']

    send_mail(title,body,'dsouza.kevin952@gmail.com',['dsouza.kevin952@gmail.com'],fail_silently=False)
    return render(request,'news/base.html')




def earthquake(request):
    return render(request,'news/earthquake.html')

def storms(request):
    return render(request,'news/storms.html')

def floods(request):
    return render(request,'news/floods.html')

def wildfire(request):
    return render(request,'news/wildfire.html')

def pandemic(request):
    return render(request,'news/pandemic.html')

def violence(request):
    return render(request,'news/violence.html')

def first_aid(request):
    return render(request,'news/first-aid.html')
