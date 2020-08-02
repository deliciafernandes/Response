from django.urls import path,include
from . import views
# from rest_framework import routers

# router  = routers.DefaultRouter()
# router.register('news',views.relevanceview)


urlpatterns = [
    path('', views.homepage, name='news-home'),
    path('signIn/',views.signIn, name='signIN'),
    path('message/',views.message, name='alert'),
    path('register/',views.register, name='user-register'),
    path('flood/',views.floods, name='floods'),
    path('earthquake/',views.earthquake, name='earthquake'),
    path('wildfire/',views.wildfire, name='wildfire'),
    path('storms/',views.storms, name='storms'),
    path('pandemic/',views.pandemic, name='pandemic'),
    path('violence/',views.violence, name='violence'),
    path('first-aid/',views.first_aid, name='first-aid'),
    path('relief/',views.Relief_help, name='rel-help'),
    # path("subscribe/", views.subscribe, name="subscribe"),
    path('email/',views.test_email,name='test_email')
    # path('api/',include(router.urls)),
]
