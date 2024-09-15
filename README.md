# Team 5 HelloWorld App with Streamlit and Jupyter

This Docker container runs both a Streamlit app at `/team5` and a Jupyter Notebook at `/team5/jupyter`, accessible via port 80 without needing to specify a port in the URL.

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
     docker build -t team-app .
     ```

5. **Run the Docker Container**:
   - Use the following command to run the Docker container, mapping the container's port 80 to the host's port 80:
     ```bash
     docker run -p 80:80 team-app
     ```

6. **Access the Applications**:
   - **Streamlit** will be accessible at: `http://localhost/team5`
   - **Jupyter Notebook** will be accessible at: `http://localhost/team5/jupyter`

### Key Features of the Solution

- **Mamba** ensures fast environment setup and dependency management.
- **Nginx** handles the routing, so you don't need to specify ports in the URL.
- **Supervisor** manages the services, keeping **Streamlit** and **Jupyter Notebook** running.
- **Cross-platform compatibility** for **Windows, Linux, and macOS (including Sonoma with Apple M1 CPU)**.
  
### Conclusion

This solution is designed to work automatically without manual intervention on multiple platforms. It uses **Mamba** for efficient dependency management, **Nginx** for reverse proxying, and **Supervisor** to manage the processes. Both **Streamlit** and **Jupyter Notebook** are served on port 80 and accessible at `/team5` and `/team5/jupyter`, respectively.


## Requirements
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) must be installed on your machine.
- [Docker](https://docs.docker.com/get-docker/) must be installed on your machine.
