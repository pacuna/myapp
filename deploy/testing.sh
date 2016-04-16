#!/bin/bash
docker create network testing
docker pull postgres:9.4
docker pull elasticsearch:2
docker run --name postgres --net testing -e POSTGRES_PASSWORD=secretpassword -d postgres:9.4 &&
docker run --name elasticsearch --net testing -d elasticsearch:2 &&

docker build -t myapp-test .
docker run --name myapp-test --net testing -e PASSENGER_APP_ENV=test --entrypoint="./deploy/rspec.sh" -t myapp-test | perl -pe '/Tests failed inside docker./ && `echo -n "Tests failed" > docker-tests-failed`'
if [ ! -f docker-tests-failed ]; then
  echo -e "No docker-tests-failed file. Apparently tests passed."
else
  echo -e "docker-tests-failed file found, so build failed."
  rm docker-tests-failed
  echo 'removing test containers'
  docker rm -f myapp-test
  docker rm -f postgres
  docker rm -f elasticsearch
  docker network rm testing
  exit 1
fi
echo 'removing test containers'
docker rm -f myapp-test
docker rm -f postgres
docker rm -f elasticsearch
docker network rm testing
