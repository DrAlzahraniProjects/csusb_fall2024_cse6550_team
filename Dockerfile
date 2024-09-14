# Use the official Python image
FROM python:3.11

# Set the working directory
WORKDIR /app

# Install Mamba and Jupyter
RUN pip install mamba jupyter

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the Python dependencies
RUN pip install -r requirements.txt

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy the Nginx configuration script into the container
COPY setup_nginx.sh /usr/local/bin/setup_nginx.sh

# Make the Nginx setup script executable
RUN chmod +x /usr/local/bin/setup_nginx.sh

# Copy the Streamlit app into the container
COPY app.py app.py

# Expose port 5005
EXPOSE 5005

# Run Nginx and Streamlit
ENTRYPOINT ["/usr/local/bin/setup_nginx.sh"]
CMD ["streamlit", "run", "app.py", "--server.port=5005", "--server.baseUrlPath=/team"]
