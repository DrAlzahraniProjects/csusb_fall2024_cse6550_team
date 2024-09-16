# Team 5 HelloWorld App with Streamlit

This Docker container runs a Streamlit app.

## How to Run

1. **Clone the repository:**
    ```bash
    git clone https://github.com/DrAlzahraniProjects/csusb_fall2024_cse6550_team5.git
    ```

2. **Navigate to the project folder:**
    ```bash
    cd csusb_fall2024_cse6550_team5
    ```

3. **Get the latest updates:**
    ```bash
    git pull origin main
    ```


### Steps to Build and Run the Solution

4. **Build the Docker Image**:
   - Run the following command to build the Docker image:
     ```bash
     docker build -t team5-app .
     ```

5. **Run the Docker Container**:
   - Use the following command to run the Docker container, mapping the container's port 5005 to the host's port 5005:
     ```bash
     docker run -d -p 5005:5005 --name team5-container team5-app
     ```

6. **Access the Applications**:
   - **Streamlit** will be accessible at: `http://localhost/5005`

## Requirements
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) must be installed on your machine.
- [Docker](https://docs.docker.com/get-docker/) must be installed on your machine.
