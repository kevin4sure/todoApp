from django.http import JsonResponse
from django.core import serializers
from django.views.decorators.csrf import csrf_exempt
import json
# Create your views here.
from .models import TaskList

def ViewList(request):
    if request.method == 'GET':
        all_tasks = serializers.serialize('json', TaskList.objects.all())
        return JsonResponse({'success':True,'all_tasks':json.loads(all_tasks)})
    return JsonResponse({})    

@csrf_exempt
def CreateListItem(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        try:
            new_task = TaskList.objects.create(title=title)
            new_task.save()
        except Exception as e: return JsonResponse({'success':False,'message':'some error occurred while trying to save the data.','error_msg':e.__str__})    
        all_tasks = serializers.serialize('json', TaskList.objects.all())
        return JsonResponse({'success': True, 'all_tasks': json.loads(all_tasks)})

