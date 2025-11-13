// This pipeline automates the build, deployment, and validation of the Ruby WebServer Docker image.
pipeline {
    agent any // Instructs Jenkins to run the pipeline on any available agent
    
    stages {
        // STAGE 1: Build the Docker Image (Automating Alisha's contribution)
        stage('Build Image') {
            steps {
                echo 'Building Docker image...'
                // Tags the image with the unique Jenkins BUILD_NUMBER for version control and traceability
                sh 'docker build -t ruby-webserver:$BUILD_NUMBER .' 
            }
        }
        
        // STAGE 2: Deploy the Container (Automating Tanisha's deployment steps)
        stage('Deploy Container') {
            steps {
                echo 'Stopping and removing old container for clean deployment...'
                // Stop/Remove commands use '|| true' so the pipeline doesn't fail if the container doesn't exist yet
                sh 'docker stop my-ruby-app || true' 
                sh 'docker rm my-ruby-app || true'
                
                // Run the new container with the fixed port mapping (8000:8080)
                sh 'docker run -d -p 8000:8080 --name my-ruby-app ruby-webserver:$BUILD_NUMBER' 
            }
        }
        
        // STAGE 3: Validate the Application (Automating the Definitive Proof)
        stage('Validate Application') {
            steps {
                echo 'Waiting 5 seconds for WebServer process to start...'
                sh 'sleep 5'
                // This command proves the server is functional inside the container.
                sh 'docker exec my-ruby-app curl http://127.0.0.1:8080' 
            }
        }
    }
    
    // Cleanup/Reporting
    post {
        success {
            echo 'SUCCESS! The automated deployment and validation passed.'
        }
        failure {
            echo 'FAILURE! Check logs in the Validate Application stage.'
        }
    }
}