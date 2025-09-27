pipeline {
    agent any

    environment {
        VENV_NAME = 'venv'
        PYTHON_VENV = "./${VENV_NAME}/bin/python3"
        APP_DIR = 'myapp' 
    }

    stages {
        stage('Install Dependencies') {
            steps {
                dir("${APP_DIR}") {
                    sh 'echo "Setting up virtual environment and installing dependencies..."'

                    // 1. Create the virtual environment
                    sh "python -m venv ${VENV_NAME}"
                    sh "${PYTHON_VENV} --version" // Optional check

                    // 2. Install dependencies
                    sh "${PYTHON_VENV} -m pip install -r requirements.txt"
                    sh "${PYTHON_VENV} -m pip list"
                }
            }
        }

        stage('Run Python Script') {
            steps {
                dir("${APP_DIR}") {
                    sh 'echo "Executing the main script (main.py)..."'
                    sh "${PYTHON_VENV} main.py"
                }
            }
        }

        stage('Cleanup') {
            steps {
                dir("${APP_DIR}") {
                    sh 'echo "Cleaning up virtual environment..."'
                    sh "rm -rf ${VENV_NAME}"
                }
            }
        }
    }
}

