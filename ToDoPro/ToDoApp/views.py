from django.http import JsonResponse
from django.core import serializers
import json
# Create your views here.
from .models import TaskList

def ViewList(request):
    all_tasks = serializers.serialize('json', TaskList.objects.all())
    return JsonResponse({'all_tasks':json.loads(all_tasks)})
