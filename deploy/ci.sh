#!/bin/sh

USERNAME=${CREDENTIALS%:*}
PASSWORD=${CREDENTIALS#*:}

sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" ./deploy/kube/rcs/myapp.yaml > temp.yaml

LAST_SUCCESSFUL_BUILD=$(curl http://${USERNAME}:${PASSWORD}@52.38.170.255:8080/job/myapp/lastSuccessfulBuild/buildNumber)

/usr/bin/kubectl rolling-update myapp-v${LAST_SUCCESSFUL_BUILD} -f temp.yaml --namespace production

if [ $? -eq 0 ]
then
  echo "Deployment successful"
else
  echo "Deployment stopped."
  exit 1
fi

rm temp.yaml
