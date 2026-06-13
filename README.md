# Demo Devops Python

This is a simple application to be used in the technical test of DevOps.

## Getting Started

### Prerequisites

- Python 3.11.3

### Installation

Clone this repo.

```bash
git clone https://bitbucket.org/devsu/demo-devops-python.git
```

Install dependencies.

```bash
pip install -r requirements.txt
```

Migrate database

```bash
py manage.py makemigrations
py manage.py migrate
```

### Database

The database is generated as a file in the main path when the project is first run, and its name is `db.sqlite3`.

Consider giving access permissions to the file for proper functioning.

## Usage

To run tests you can use this command.

```bash
py manage.py test
```

To run locally the project you can use this command.

```bash
py manage.py runserver
```

Open http://localhost:8000/api/ with your browser to see the result.

### Features

These services can perform,

#### Create User

To create a user, the endpoint **/api/users/** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "detail": "error"
}
```

#### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

#### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "detail": "Not found."
}


```

# Clonar el repositorio
git clone https://github.com/pintomaynor98-web/demo-devops-python.git
cd demo-devops-python


# Instalar dependencias
pip install -r requirements.txt

# Migrar base de datos
python manage.py makemigrations
python manage.py migrate
### DOCKER

# 1. Construir la imagen localmente
docker build -t tu-usuario/nombre-de-tu-imagen .

# 2. Ejecutar contenedor de prueba
docker run -d -p 8000:8000 --name django-app tu-usuario/nombre-de-tu-imagen

# 3. Ver logs del contenedor
docker logs -f django-app
### kubernets 
# 1. Asegúrate de estar en el contexto de Docker Desktop
kubectl config use-context docker-desktop

# 2. Aplicar manifiestos de configuración
kubectl apply -f k8s/

# 3. Verificar estado
kubectl get pods
kubectl get svc

# 4. Acceder al servicio


### Diagrama Kubernets
PETICIÓN DEL CLIENTE
                |
                v
      +-------------------+
      |      Service      | <--- Balanceador de carga interno
      +---------+---------+
            /         \
           /           \
+------------------+ +------------------+
|      POD 1       | |      POD 2       |
| +--------------+ | | +--------------+ |
| | Gunicorn/App | | | | Gunicorn/App | |
| +--------------+ | | +--------------+ |
| |   Volumen    | | | |   Volumen    | |
| | Compartido   |===| | Compartido   | |
| +--------------+ | | +--------------+ |
+------------------+ +------------------+
          |                  |
          +----[ PVC ]-------+

La aplicación utiliza SQLite3 con un Persistent Volume Claim (PVC) para garantizar la persistencia de datos tras reinicios. Aunque esta configuración permite alta disponibilidad con dos réplicas, SQLite presenta limitaciones de concurrencia al ser una base de datos basada en archivos. Para escalar a entornos de alta demanda, se tiene planificada la migración a una base de datos relacional (como PostgreSQL), permitiendo una gestión de bloqueos más eficiente y mayor rendimiento bajo carga.
### Diagrmama Pipeline

1. [CÓDIGO] → GITHUB (Push a master)
      |
2. [CI: INTEGRACIÓN] → Entorno Ubuntu
      |-- Instalar dependencias
      |-- Calidad (Flake8)
      |-- Seguridad (Safety)
      |-- Pruebas (Pytest + Cobertura)
      |
3. [BUILD: EMPAQUETADO] → Docker Hub
      |-- Construir imagen (:SHA + :latest)
      |-- Push al registro
      |
4. [CD: DESPLIEGUE] → Kubernetes (Self-hosted runner)
      |-- kubectl apply (Aplica cambios en YAML)
      |-- kubectl set image (Actualiza imagen en Deployment)
      |-- kubectl rollout (Actualización sin interrupción)
      |-- kubectl wait (Espera a que los pods estén listos)
      |
5. [VERIFICACIÓN] → Health Check
      |-- Ejecutar curl en pod activo
      |
6. [ERROR HANDLING] → Si falla (if: failure())
      |-- Captura logs y estado (Describe/Logs)
 ## Estructura de archivos

 /
├── k8s/               # archivos de configuración de Kubernetes
├── .github/workflows/ # archivo .yml del pipeline
├── Dockerfile         # plano de construcción Docker
├── README.md          # Documentación 
├── requirements.txt
└── manage.py
## License

Copyright © 2023 Devsu. All rights reserved.
