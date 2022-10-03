from rest_framework.routers import DefaultRouter

from task_center.views import TaskViewSet

router = DefaultRouter()
router.register('tasks', TaskViewSet)

urlpatterns = router.urls
