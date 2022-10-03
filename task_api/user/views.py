from rest_framework.response import Response
from rest_framework import permissions
from rest_framework.generics import CreateAPIView, GenericAPIView

from user.serializers import UserSerializer


class UserCreateView(CreateAPIView):
    serializer_class = UserSerializer


class UserInfoView(GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]
    http_method_names = ['get', 'head']

    @staticmethod
    def get(request, *args, **kwargs):
        serialized_data = UserSerializer(instance=request.user, many=False)
        return Response(serialized_data.data)
