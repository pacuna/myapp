#!/bin/sh
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" ./deploy/kube/myapp.yaml > temp.yaml

# /usr/bin/kubectl rolling-update myapp-v${BUILD_NUMBER-1} -f temp.yaml
/usr/bin/kubectl rolling-update myapp-v12 -f temp.yaml

if [ $? -eq 0 ]
then
  echo "Deployment successful"
else
  echo "Deployment stopped."
  exit 1
fi

rm temp.yaml
