# Use Miniconda3 base image
FROM continuumio/miniconda3:latest

# Set environment variables
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1

# Install Streamlit, Jupyter, and Nginx
RUN conda install -c conda-forge streamlit jupyter && \
    apt-get update && \
    apt-get install -y nginx

# Set up working directory
WORKDIR /app

# Copy application files
COPY app.py /app/
COPY requirements.txt /app/
COPY README.md /app/
COPY nginx.conf /etc/nginx/nginx.conf

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx and Streamlit
CMD ["/bin/bash", "-c", "service nginx start && streamlit run app.py --server.port=5005 --server.baseUrlPath=/team5"]
