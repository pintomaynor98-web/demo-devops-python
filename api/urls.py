from django.urls import path, include
from django.http import HttpResponse, JsonResponse
from rest_framework import routers
from .views import UserViewSet

router = routers.DefaultRouter()
router.register('users', UserViewSet, 'users')

# Healthcheck liviano (recomendado para Kubernetes)
def health_check(request):
    return JsonResponse({
        "status": "ok"
    })

urlpatterns = [
    # Healthcheck para Kubernetes
    path('health/', health_check),

    # API principal
    path('api/', include(router.urls)),
]