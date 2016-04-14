sed -e "s;%BUILD_NUMBER%;0;g" ./deploy/kube/myapp.yaml
# /usr/bin/kubectl rolling-update myapp-v_%BUILD_NUMBER-1% -f myapp.yml
/usr/bin/kubectl rolling-update myapp-v2 -f myapp.yml
