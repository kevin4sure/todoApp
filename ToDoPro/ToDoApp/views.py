from django.http import JsonResponse, QueryDict
from django.core import serializers
from django.views.decorators.csrf import csrf_exempt
import json
# Create your views here.
from .models import TaskList

@csrf_exempt
def ViewList(request):
    if request.method == 'GET':
        # all_tasks = serializers.serialize('json', TaskList.objects.all())
        # return JsonResponse({'success':True,'all_tasks':json.loads(all_tasks)})
        all_tasks = list(TaskList.objects.all().values('id','title'))
        return JsonResponse({'success':True,'data': all_tasks})

    if request.method == 'POST':
        title = request.POST.get('title')
        try:
            new_task = TaskList.objects.create(title=title)
            new_task.save()
        except Exception as e: return JsonResponse({'success':False,'message':'some error occurred while trying to save the data.','error_msg':e.__str__()})    
        all_tasks = serializers.serialize('json', TaskList.objects.all())
        return JsonResponse({'success': True,'operation':'retrieve', 'all_tasks': json.loads(all_tasks)})

@csrf_exempt
def EditDeleteListItem(request,list_id):
    try:
        task_item = TaskList.objects.get(id=list_id)
    except TaskList.DoesNotExist as e:
        return JsonResponse({'success':False,'message':'task item does not exist.'})

    if request.method == 'PUT':
        # because django doesn't understand the rest requests like PUT, DELETE, etc.
        if hasattr(request, '_post'):
            del request._post
            del request._files
        try:
            request.method = "POST"
            request._load_post_and_files()
            request.method = "PUT"
        except AttributeError:
            request.META['REQUEST_METHOD'] = 'POST'
            request._load_post_and_files()
            request.META['REQUEST_METHOD'] = 'PUT'
            
        request.PUT = request.POST
        ###########################################################################
        
        title = request.POST.get('title')
        print(title)
        try:
            task = TaskList(id=list_id,title=title)
            task.save()
        except Exception as e: return JsonResponse({'success':False,'message':'some error occurred while trying to update the data.','error_msg':e.__str__()})    
        
        updated_task = serializers.serialize('json', [task])
        return JsonResponse({'success': True,'operation':'update', 'updated_task': json.loads(updated_task)})

    elif request.method == 'DELETE':
        task_item.delete()
        return JsonResponse({'success':True,'operation':'delete'})

    else:
        _task = task_item
        return JsonResponse({'success': True,'operation':'update', 'updated_task': json.loads(_task)})   
                    


