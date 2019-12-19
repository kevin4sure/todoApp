from django.urls import path

from . import views
urlpatterns = [
    path('',views.ViewList,name="all_tasks"),
    path('<int:list_id>/', views.EditDeleteListItem,name='edit_delete_task')
]
