from django.contrib import admin
from django.urls import path, include
from api.views import health_check # Importas la función de salud

urlpatterns = [
    path('admin/', admin.site.urls),
    
    
    path('health/', health_check), 
    
    # Y aquí incluyes el resto de tus rutas de la API
    path('api/', include('api.urls')),
]