sed -e "s;%BUILD_NUMBER%;0;g" deploy/kube/myapp.yml
kubectl rolling update myapp-v_%BUILD_NUMBER-1% -f myapp.yml
