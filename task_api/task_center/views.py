from rest_framework.permissions import IsAuthenticated
from rest_framework.viewsets import ModelViewSet

from task_center.serializers import Task, TaskSerializer


class TaskViewSet(ModelViewSet):
    permission_classes = [IsAuthenticated]
    serializer_class = TaskSerializer
    queryset = Task.objects.all()    

    def get_queryset(self):
        queryset = super(TaskViewSet, self).get_queryset().filter(author=self.request.user).order_by('-id')
        return queryset

    