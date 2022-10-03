from django.urls import path
from rest_framework.routers import DefaultRouter

from user.views import UserCreateView, UserInfoView

app_name = 'users'

urlpatterns = [
    path('signup/', UserCreateView.as_view(), name='user-create-view'),
    path('info/', UserInfoView.as_view(), name='user-info-view')
]
