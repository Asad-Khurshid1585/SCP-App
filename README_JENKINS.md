# Jenkins deployment instructions

This repository contains a `Jenkinsfile` and simple deploy scripts to run the Flask app.

Quick overview
- `Jenkinsfile` — Declarative Pipeline: checkout, create venv, install requirements, run SonarQube analysis, deploy.
- `scripts/jenkins_deploy.sh` — Unix deploy script (uses gunicorn when available).
- `scripts/jenkins_deploy.bat` — Windows deploy script.
- `sonar-project.properties` — SonarQube configuration for SAST.

Recommended Jenkins job
1. Create a new Pipeline job in Jenkins.
2. Under "Pipeline" set "Definition" to "Pipeline script from SCM" and point to your Git repo.
3. Ensure `Jenkinsfile` is at the repository root or update the path accordingly.
4. Make sure the agent/node Jenkins runs on has Python 3 installed and network access to pip packages.

SonarQube Setup for SAST
1. Install SonarQube server (e.g., via Docker: `docker run -d -p 9000:9000 sonarqube:latest`).
2. In Jenkins, install the "SonarQube Scanner" plugin.
3. In Jenkins global config, add SonarQube server under "Configure System" > "SonarQube servers" (name: 'SonarQube', URL: http://your-sonarqube-server:9000, token from SonarQube).
4. On the Jenkins agent, install sonar-scanner (e.g., `sudo apt install sonar-scanner` on Ubuntu).
5. The pipeline will run SAST; check results in SonarQube dashboard.

Optional configuration
- Add a GitHub/Bitbucket webhook to trigger builds on push.
- Install the following Jenkins plugins if not installed: Pipeline, Git, GitHub Integration (if using GitHub), Blue Ocean (optional).

Local testing
 - On Windows (cmd.exe):
```
python -m venv venv
call venv\Scripts\activate
pip install -r requirements.txt
python app.py
```

 - On Linux/macOS (bash):
```
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt
gunicorn -w 4 -b 0.0.0.0:8000 app:app    # if gunicorn installed
```

Notes & next steps
- If you want a production-ready deployment, run the app behind a reverse proxy (nginx), or use a container (Docker) and deploy with a container orchestration strategy.
- If you want me to add a Dockerfile + Pipeline using Docker, tell me and I will add it.

Updated from folder2.

Updated from folder1.
