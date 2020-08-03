from django.urls import path,include
from . import views
# from rest_framework import routers

# router  = routers.DefaultRouter()
# router.register('news',views.relevanceview)


urlpatterns = [
    path('', views.homepage, name='news-home'),
   
    path('message/',views.message, name='alert'),
 
    path('flood/',views.floods, name='floods'),
    path('earthquake/',views.earthquake, name='earthquake'),
    path('wildfire/',views.wildfire, name='wildfire'),
    path('storms/',views.storms, name='storms'),
    path('pandemic/',views.pandemic, name='pandemic'),
    path('violence/',views.violence, name='violence'),
    path('first-aid/',views.first_aid, name='first-aid'),
    path('relief/',views.Relief_help, name='rel-help'),
    path('relief2/',views.Relief_help2, name='rel-help2'),
    path('email/',views.test_email,name='test_email')
    
]
