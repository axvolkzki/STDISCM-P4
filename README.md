# Online Enrollment System

### **Distributed Fault Tolerance**

A web-based *Distributed Online Enrollment System* built with *Ruby on Rails*, following the *Model-View-Controller (MVC)* architecture. The system is designed to run as distributed microservices across multiple nodes, enabling fault tolerance and modular functionality.

## Project Specifications

This system is built to demonstrate *distributed systems* capabilities with fault isolation and service independence.

### Minimum Features

1. *Authentication* – Login/Logout using *Json Web Token (JWT)*.
2. *View Courses* – Browse available open courses.
3. *Enroll to Courses* – Students can enroll in available courses.
4. *View Grades* – Students can view previously uploaded grades.
5. *Upload Grades* – Faculty can upload grades for their students.


## Video Demonstration
For easy accessibility, the following links are provided:

- *[Canva Presentation](https://www.canva.com/design/DAGkavaIHrU/tk57j03809sk7GkaopCMbQ/edit?utm_content=DAGkavaIHrU&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)*
- *YouTube:* 

## Slides
Access the presentation slides through the provided link:

- *[Canva Slides](https://www.canva.com/design/DAGkbqel0qE/TsMJCTJ6gfpee9B5qJSGLQ/edit?utm_content=DAGkbqel0qE&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)*


## System Architecture

Each service is deployed on a separate *node*, representing a unique Docker container or networked virtual machine. When a node/service goes down, only that specific functionality becomes unavailable—**the rest of the system continues to operate**.


## Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
(Optional) VirtualBox/Vagrant or remote machines for simulating real nodes


## Setup Instructions

1. Clone the repository or download the Zip file.
    ```sh
    git clone https://github.com/axvolkzki/STDISCM-P4
    ```

2. Navigate into the project.
    ```sh
    cd STDISCM-P4
    ```

3. Set up the configuration by copying the .env.sample template:
    ```sh
    cp .env.sample .env
    ```
    
    Edit the .env with required variables:
    ```sh
    POSTGRES_USER=
    POSTGRES_DB=
    POSTGRES_PASSWORD=
    JWT_SECRET_KEY=
    ```

4. Build and start services
    ```sh
    docker-compose up --build       # building docker
    ```
    
    Incase to down the docker
    ```sh
    docker compose down -v --remove-orphans
    ```

5. Setup databases per services
    ```sh
    docker-compose exec authentication rails db:create db:migrate db:seed
    docker-compose exec view_courses rails db:migrate db:seed
    docker-compose exec enroll_course rails db:migrate db:seed
    docker-compose exec view_grades rails db:migrate db:seed
    docker-compose exec upload_grades rails db:migrate db:seed
    ```
    

## Access Points
**Service	URL**

- Frontend	        http://localhost:3000
- Authentication	http://localhost:3001
- Courses	        http://localhost:3002
- Enrollment	    http://localhost:3003
- View Grades	    http://localhost:3004
- Upload Grades	    http://localhost:3005