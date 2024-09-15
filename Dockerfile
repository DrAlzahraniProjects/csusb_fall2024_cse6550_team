# Base image with Python
FROM python:3.9

# Install necessary dependencies for Jupyter, Streamlit, and Supervisor
RUN apt-get update && apt-get install -y nginx supervisor

# Set the working directory inside the container
WORKDIR /app

# Copy app and configuration files into the container
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy Nginx and Supervisor configurations
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx.conf /etc/nginx/sites-available/default

# Expose ports: Nginx will serve on port 80
EXPOSE 80

# Run Supervisor to manage both Jupyter and Streamlit services
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
