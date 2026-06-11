# Usamos una imagen base de Python ligera
FROM python:3.11-slim

# Evitamos archivos temporales de Python y buffers
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Directorio donde vivirá la app en el contenedor
WORKDIR /app

# Instalamos herramientas necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiamos los requerimientos e instalamos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos todo el código de tu carpeta a la imagen
COPY . .

# Seguridad: ejecutamos como un usuario sin privilegios
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

# Exponemos el puerto y ejecutamos con gunicorn
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "demo.wsgi:application"]