pipeline {
    // 1. Define the agent where the job will run
    agent any

    // 2. Environment variables
    environment {
        // Define the name for your virtual environment folder
        VENV_NAME = 'venv'
        // Define the path to the Python executable within the venv
        // Note: This path is relative to the directory where the venv is created (inside 'myapp/')
        PYTHON_VENV = ".\$VENV_NAME/bin/python"
        
        // Define the subdirectory where the code lives
        APP_DIR = 'myapp' 
    }

    // 3. Define the steps to execute
    stages {
        stage('Install Dependencies') {
            steps {
                // Change the directory to 'myapp' for all subsequent actions in this stage
                dir("\$APP_DIR") {
                    sh 'echo "Setting up virtual environment and installing dependencies..."'
                    
                    // 1. Create the virtual environment
                    sh "python -m venv \$VENV_NAME"
                    sh ".\$PYTHON_VENV --version" // Optional check
                    
                    // 2. Install dependencies using the venv's pip
                    // requirements.txt is now searched for inside 'myapp/'
                    sh ".\$PYTHON_VENV -m pip install -r requirements.txt"
                    sh ".\$PYTHON_VENV -m pip list" // Verify packages are installed
                }
            }
        }

        stage('Run Python Script') {
            steps {
                // Change the directory to 'myapp' before running the script
                dir("\$APP_DIR") {
                    sh 'echo "Executing the main script (main.py)..."'
                    // Execute main.py using the virtual environment's Python
                    sh ".\$PYTHON_VENV main.py"
                }
            }
        }

        // Clean up stage (optional, but highly recommended)
        stage('Cleanup') {
            when {
                // The 'always()' ensures cleanup runs even if the script failed
                always() 
            }
            steps {
                // Clean up the venv inside 'myapp/'
                dir("\$APP_DIR") {
                    sh 'echo "Cleaning up virtual environment..."'
                    // The 'rm -rf' command removes the venv folder and its contents
                    sh "rm -rf \$VENV_NAME"
                }
            }
        }
    }
}
