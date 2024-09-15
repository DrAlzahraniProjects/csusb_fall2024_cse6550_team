# Use a base image with multi-platform support
FROM continuumio/miniconda3

# Set environment variables
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install necessary packages
RUN conda install -c conda-forge streamlit jupyter

# Create and set the working directory
WORKDIR /app

# Copy the application files into the container
COPY app.py /app/
COPY requirements.txt /app/
COPY README.md /app/

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose the port Streamlit will run on
EXPOSE 5005

# Command to run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=5005", "--server.baseUrlPath=/team5"]
