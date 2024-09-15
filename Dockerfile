# Use a base image with multi-platform support
FROM mambaorg/mambaforge:latest

# Set environment variables
ENV PORT=5005

# Create and set the working directory
WORKDIR /app

# Copy application files
COPY app.py .
COPY requirements.txt .

# Install dependencies
RUN micromamba create -n team-env python=3.8 \
    && micromamba activate team-env \
    && pip install -r requirements.txt \
    && micromamba install -n team-env jupyter \
    && micromamba clean --all --yes

# Expose the application port
EXPOSE 5005

# Set environment variable for Streamlit to use the specified port
ENV STREAMLIT_SERVER_PORT=5005

# Command to run Streamlit and Jupyter
CMD ["sh", "-c", "streamlit run app.py --server.port $PORT & jupyter notebook --no-browser --ip=0.0.0.0 --port=5005 --NotebookApp.base_url=/Jupyter"]
