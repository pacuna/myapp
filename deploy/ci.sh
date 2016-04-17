#!/bin/sh

USERNAME=${CREDENTIALS%:*}
PASSWORD=${CREDENTIALS#*:}

if [ "${JOB_NAME}" = "myapp-production" ]; then

  sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" ./deploy/kube/rcs/myapp-production.yaml > temp.yaml
  LAST_SUCCESSFUL_BUILD=$(curl http://${USERNAME}:${PASSWORD}@52.38.170.255:8080/job/myapp-production/lastSuccessfulBuild/buildNumber)
  /usr/bin/kubectl rolling-update myapp-v${LAST_SUCCESSFUL_BUILD} -f temp.yaml --namespace production
  if [ $? -eq 0 ]
  then
    echo "Deployment successful"
  else
    echo "Deployment stopped."
    exit 1
  fi
  rm temp.yaml

elif [ "${JOB_NAME}" = "myapp-staging" ]; then

  sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" ./deploy/kube/rcs/myapp-staging.yaml > temp.yaml
  LAST_SUCCESSFUL_BUILD=$(curl http://${USERNAME}:${PASSWORD}@52.38.170.255:8080/job/myapp-staging/lastSuccessfulBuild/buildNumber)
  /usr/bin/kubectl rolling-update myapp-v${LAST_SUCCESSFUL_BUILD} -f temp.yaml --namespace staging
  if [ $? -eq 0 ]
  then
    echo "Deployment successful"
  else
    echo "Deployment stopped."
    exit 1
  fi
rm temp.yaml
fi

