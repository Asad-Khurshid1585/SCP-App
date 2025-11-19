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
            sh '''
if python3 -c "import venv" 2>/dev/null; then
  python3 -m venv ${VENV_DIR}
else
  python3 -m pip install --user virtualenv
  ~/.local/bin/virtualenv ${VENV_DIR}
fi
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
