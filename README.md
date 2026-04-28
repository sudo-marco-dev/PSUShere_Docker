PSUSphere Dockerized Deployment

This repository contains the Docker configuration files for PSUSphere, a Django-based application. This setup follows the "build once, run anywhere" principle, allowing for a consistent environment across different machines.  
📂 Project Structure

    projectsite/: The core Django project directory containing manage.py.  

    Dockerfile: Instructions to build the Django application image.  

    docker-compose.yml: Configuration for building and running the app in a development environment.  

    requirements.txt: Python dependencies for the project.  

    .dockerignore: Files and folders to be excluded from the Docker image.  

    for_client/:

        docker-compose.yml: A simplified configuration for end-users to pull and run the image directly from Docker Hub.  

🛠️ Prerequisites

Before running the application, ensure you have the following installed:

    Docker Desktop (for Windows/Mac) or Docker Engine (for Linux).  

    Docker Compose.  

🚀 For Developers: Building the Image

If you want to build the image locally from the source code, follow these steps:

    Build the Image:
    Bash

    docker-compose build

    Run the Container:
    Bash

    docker-compose up -d

    Run Initial Migrations:
    Bash

    docker-compose exec web python manage.py migrate

📦 For Clients: Running with a Single Command

To run the application without building it from source code, use the configuration provided in the for_client folder.  

    Navigate to the client folder:
    Bash

    cd for_client

    Start the application:
    Bash

    docker-compose up -d

    This command pulls the pre-built image from Docker Hub and starts the service.  

    Access the App:
    Open your browser and go to: http://localhost:8000.  

🔑 Administrative Setup (First Time Only)

To access the Django admin dashboard, you must create a superuser while the container is running:  
Bash

docker-compose exec web python manage.py createsuperuser

📝 Configuration Details

    Container Engine: Uses Docker to share the host OS kernel for a lightweight footprint.  

    Database: Configured to use SQLite by default, with volume persistence mapped to the host machine.  

    Environment: Python 3.11/3.12-slim base image for optimized size.
