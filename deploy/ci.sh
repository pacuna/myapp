sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" ./deploy/kube/myapp.yaml > temp.yaml
/usr/bin/kubectl rolling-update myapp-v_${BUILD_NUMBER-1} -f temp.yaml
rm temp.yaml
