# 🚀 Focus Task - CI/CD Pipeline with Jenkins, Docker, and AWS

This project demonstrates a complete CI/CD pipeline that automates the build, test, and deployment of a React application using **Jenkins**, **Docker**, **GitHub**, and **AWS EC2**.

---

## 🔄 CI/CD Workflow

The pipeline is fully automated using Jenkins. Here's how the process works:

1. **Code Push to GitHub**
   - Developer pushes updated code to the `main` branch of the GitHub repository.

2. **Jenkins CI Trigger**
   - Jenkins automatically pulls the latest code from GitHub.

3. **Docker Image Build**
   - Jenkins builds a Docker image using the `Dockerfile` that serves the React app via Nginx.

4. **Push to Docker Hub**
   - The newly built Docker image is pushed to Docker Hub under the repository `saravanan141297/focus-task`.

5. **Remote Deployment to AWS EC2**
   - Jenkins SSHs into an AWS EC2 instance.
   - Pulls the latest image from Docker Hub.
   - Stops and removes any existing container.
   - Runs the new container on port `80`.

6. **Live Application**
   - The latest version of the app is live and accessible via the EC2's public IP.

---

## 🛠️ Tools & Technologies Used

| Tool/Platform     | Purpose                                      |
|------------------|----------------------------------------------|
| **GitHub**        | Source code management and version control   |
| **Jenkins**       | Automation server to manage CI/CD pipeline   |
| **Docker**        | Containerization of the application          |
| **Docker Hub**    | Registry to store Docker images              |
| **AWS EC2 (Ubuntu)** | Hosting the production containerized app |
| **Nginx**         | Web server used to serve the React build     |

---

## ✅ How to Test & Deploy

### 🔧 Pre-requisites
- Docker installed on Jenkins and EC2
- Jenkins installed and running (on VM or server)
- SSH Key added to Jenkins credentials for EC2
- Docker Hub credentials added to Jenkins credentials

### 🔁 Triggering the Pipeline

1. Push any change to the `main` branch of the repo:
   ```bash
   git add .
   git commit -m "Your message"
   git push origin main
