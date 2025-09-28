pipeline {

    // Specify the agent if needed
    agent any

    // Set up the env. variables
    environment {
        VENV_NAME = 'venv'  // python virtual environment
        PYTHON_VENV = "./${VENV_NAME}/bin/python3"
        APP_DIR = 'myapp'   // the directory of the app
    }

    stages {

        // 1. Install Dependencies
        stage('Install Dependencies') {
            steps {
                dir("${APP_DIR}") {
                    sh 'echo "Setting up virtual environment and installing dependencies..."'

                    // Create virtual environment using python3
                    sh 'python3 -m venv ${VENV_NAME}'

                    // Confirm Python from venv is working
                    sh '${PYTHON_VENV} --version'

                    // Install dependencies
                    sh '${PYTHON_VENV} -m pip install --upgrade pip'
                    sh '${PYTHON_VENV} -m pip install -r requirements.txt'
                    sh '${PYTHON_VENV} -m pip list'
                }
            }
        }

        // 2. Run Python Script
        stage('Run Python Script') {
            steps {
                dir("${APP_DIR}") {
                    sh 'echo "Executing main.py using venv Python..."'
                    sh '${PYTHON_VENV} main.py'
                }
            }
        }

        // 3. Cleanup
        stage('Cleanup') {
            steps {
                dir("${APP_DIR}") {
                    sh 'echo "Cleaning up virtual environment..."'
                    sh 'rm -rf ${VENV_NAME}'
                }
            }
        }
    }
}
