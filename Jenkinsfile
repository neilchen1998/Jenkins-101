pipeline {
    agent any

    environment {
        VENV_NAME = 'venv'
        PYTHON_VENV = "./${VENV_NAME}/bin/python3"
        APP_DIR = 'myapp'
    }

    stages {

        stage('Debug Environment') {
            steps {
                echo 'Checking environment for debugging...'
                sh 'echo PATH: $PATH'
                sh 'which python3 || echo "python3 not found"'
                sh 'python3 --version || echo "python3 not available"'
            }
        }

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

        stage('Run Python Script') {
            steps {
                dir("${APP_DIR}") {
                    sh 'echo "Executing main.py using venv Python..."'
                    sh '${PYTHON_VENV} main.py'
                }
            }
        }

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
