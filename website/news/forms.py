from django import forms
from django.core.validators import RegexValidator
import http.client







class SubscribeForm(forms.Form):
    name = forms.CharField(max_length=150, required=True, widget= forms.TextInput(attrs ={'class':"input"}))
    email = forms.EmailField( required=True, widget= forms.TextInput(attrs ={'class':"input"}))
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$', message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")
    contact = forms.CharField(validators=[phone_regex], max_length=17,required = True,  widget= forms.TextInput(attrs ={'class':"input"})) # validators should be a list



    