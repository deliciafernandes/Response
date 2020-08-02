from django import forms
from django.core.validators import RegexValidator
import http.client

def sendPhoneOTP(contact):
	conn = http.client.HTTPConnection("2factor.in")
	phone = contact[3:]
	payload = ""
	headers = { 'content-type': "application/x-www-form-urlencoded" }
	conn.request("GET", "/API/V1/293832-67745-11e5-88de-5600000c6b13/SMS/phone/AUTOGEN", payload, headers)
	res = conn.getresponse()
	data = res.read()
	print(data.decode("utf-8"))
	return data

def verifyOTP(contact):
	pass





class SubscribeForm(forms.Form):
    name = forms.CharField(max_length=150, required=True, widget= forms.TextInput(attrs ={'class':"input"}))
    email = forms.EmailField( required=True, widget= forms.TextInput(attrs ={'class':"input"}))
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$', message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")
    contact = forms.CharField(validators=[phone_regex], max_length=17,required = True,  widget= forms.TextInput(attrs ={'class':"input"})) # validators should be a list


    def sendOTP(self):
    	data = self.contact
    	if not sendPhoneOTP(contact):
    		raise forms.ValidationError('OTP verification not done')	

    	return sendPhoneOTP(contact)
    