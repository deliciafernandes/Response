from django.shortcuts import render,redirect
from django.contrib import messages,auth
# from rest_framework import viewsets
# from rest_framework.decorators import api_view
from django.core import serializers
# from rest_framework.response import Response
# from rest_framework import status
from django.http import JsonResponse
# from rest_framework.parsers import JSONParser
# from .models import relevance
# from .serializers import relevanceSerializers
from .forms import SubscribeForm
import pandas as pd
import numpy as np
import pyrebase
import requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore,auth
from urllib.parse import quote_plus
from django.core.mail import send_mail

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
    l1.append(headline)
    l1.append(description)
    l1.append(share_link)
    l1.append(image_url)
    l2.append(l1)
k = pd.DataFrame(l2,columns=['date','headline','description','share_link','image_url'])

def homepage(request):
    
    #Subscribe-user
    if request.method == 'POST':
        email = request.POST.get('email')
        contact = request.POST.get('contact')
        data = {'name':request.POST.get('name'), 'email':email, 'contact':contact }
        form =  SubscribeForm(request.POST)
        print(form)
        if form.is_valid():
            print('Valid')

            doc = db.collection(u'Users').where(u'email','==',email).where(u'contact','==',contact).get()
            if doc:
                print(doc)
                print('Email exists!')
            else:
                db.collection('Users').add(data)

        
        else:
            print('not valid')
    else:
        form = SubscribeForm()
    context2 = {
        'form':form
    }


    context1 = dict(
        data = k,
        columns = ['date','headline','description','share_link'] 
        )
    return render(request,'news/base.html',context={'context1':context1,'context2':context2})



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



# class relevanceview(viewsets.ModelViewSet):
#     queryset = relevance.objects.all()
#     serializer_class = relevanceSerializers


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
        message = 'ifoj'
        number = phone
        payload = "sender_id=FSTSMS&message="+message+"&language=english&route=p&numbers="+contact
        headers = {
        'authorization': "FWLraiHjfoSUGcBeJuOT9sQNCdPbgpw4EXI63yD720ntMA8K51WV1Kw5NTikXExzIA6y74vHJSpClFMb",
        'Content-Type': "application/x-www-form-urlencoded",
        'Cache-Control': "no-cache",
        }
        response = requests.request("POST", url, data=payload, headers=headers)
        print(response.text) 

    return render(request, 'news/base.html')

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

    return render(request, 'news/base.html')




def signIn(request):
    username = request.POST.get('user_name')
    password = request.POST.get('password')
    try:
        user = authe.sign_in_with_email_and_password(username,password)
        messages.success(request, f'{username} has logged in')
    except:
        message = "Invalid Credentials"
        return render(request, 'news/base.html', {'mess':message})

    message = "You have Logged In!"
    session_id = user['idToken']
    request.session['uid'] = str(session_id)
    return render(request,"news/base.html",{'mess':message})


def logout(request):
    authe.logout(request)
    message = "You have been logged out"

    return render(request,'news/base.html', {'mess':message})

def register(request):
    name = request.POST.get('user_name')
    password = request.POST.get('password')
    email = request.POST.get('email')
    contact = request.POST.get('contact')

    try:
    
        user = authe.create_user_with_email_and_password(email,password)

    except:
        message = "Unable to create an account!!"
        return render(request, "news/base.html",{'mess':message})
        
    uid = user['localId']
    message = "Account Created Successfully!"
    data = {"name":name , "contact":contact}
    db.child("users").child(uid).child("details").set(data)
    return render(request, "news/base.html",{'mess':message})


def message(request):
    
    phone = '8879408465'
    # user = auth.get_user_by_phone_number(phone)
    # print('Successfully fetched user data: {0}'.format(user.uid))

    # phone = phone[3:]

    doc_ref = db.collection(u'RealNews')
    snapshot = doc_ref.get()
    news = db.collection('RealNews').order_by('date',direction=firestore.Query.DESCENDING).limit(1).stream()
    for n in news:
        data = n.to_dict()

    print(data['headline'])    
    url = "https://www.fast2sms.com/dev/bulk"
    message = data['headline']
    number = phone
    payload = "sender_id=FSTSMS&message="+message+"&language=english&route=p&numbers="+number
    headers = {
    'authorization': "FWLraiHjfoSUGcBeJuOT9sQNCdPbgpw4EXI63yD720ntMA8K51WV1Kw5NTikXExzIA6y74vHJSpClFMb",
    'Content-Type': "application/x-www-form-urlencoded",
    'Cache-Control': "no-cache",
    }
    response = requests.request("POST", url, data=payload, headers=headers)
    print(response.text)    
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