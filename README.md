# CSUSB Fall 2024 CSE 6550 Team5

## How to Get Started

### Clone the Repository and Set Up Docker
Ensure you have Git and Docker installed. Then, run the following commands in your terminal or command prompt:

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

4. **Build the Docker image:**
    ```bash
    docker build -t team-app .
    ```

5. **Run the Docker container:**
    ```bash
    docker run -p 5005:5005 team-app
    ```

6. **Access the application in your browser:**
    Open your browser and go to [http://localhost/team5](http://localhost/team5)

## Requirements
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) must be installed on your machine.
- [Docker](https://docs.docker.com/get-docker/) must be installed on your machine.
