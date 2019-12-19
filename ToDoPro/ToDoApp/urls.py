from django.urls import path

from . import views
urlpatterns = [
    path('',views.ViewList,name="all_tasks")
]