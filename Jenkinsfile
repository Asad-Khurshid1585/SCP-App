pipeline {
  agent any
  environment {
    VENV_DIR = "venv"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Setup Python') {
      steps {
        script {
          if (isUnix()) {
            sh 'apt update && apt install -y python3-venv || echo "python3-venv install failed; ensure it is pre-installed on the agent"'
            sh '''
python3 -m venv ${VENV_DIR} || { echo "venv creation failed; check python3-venv installation"; exit 1; }
. ${VENV_DIR}/bin/activate
python -m pip install --upgrade pip
if [ -f requirements.txt ]; then pip install -r requirements.txt || true; fi
'''
          } else {
            bat '''
python -m venv %VENV_DIR%
@call %VENV_DIR%/Scripts/activate
python -m pip install --upgrade pip
if exist requirements.txt pip install -r requirements.txt
'''
          }
        }
      }
    }
    stage('Test (noop)') {
      steps {
        echo "No automated tests configured — skipping test stage"
      }
    }
    stage('Deploy') {
      steps {
        script {
          if (isUnix()) {
            sh 'chmod +x scripts/jenkins_deploy.sh || true'
            sh 'scripts/jenkins_deploy.sh'
          } else {
            bat 'scripts\\jenkins_deploy.bat'
          }
        }
      }
    }
  }
  post {
    always {
      archiveArtifacts artifacts: '**/logs/**', allowEmptyArchive: true
    }
  }
}
