from django import forms
from django.core.validators import RegexValidator

class SubscribeForm(forms.Form):
    name = forms.CharField(label='Name',max_length=150, required=True, widget= forms.TextInput(attrs ={'class':"input"}))
    email = forms.EmailField(label='Email Id',required=True, widget= forms.TextInput(attrs ={'class':"input"}))
    phone_regex = RegexValidator(regex=r'^\d{9,15}$', message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")
    contact = forms.CharField(label='10 digit number',validators=[phone_regex], max_length=10,required = True,  widget= forms.TextInput(attrs ={'class':"input"})) # validators should be a list
