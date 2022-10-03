from rest_framework.serializers import ModelSerializer

from task_center.models import Task


class TaskSerializer(ModelSerializer):
    class Meta:
        model = Task
        fields = '__all__'

