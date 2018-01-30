#!/bin/bash

echo

if [ ! -z $SLACK_API_TOKEN ] && [ ! -z $SLACK_USER ]
then
  echo "Using environment for SLACK_API_TOKEN & SLACK_USER"
  docker run --rm -e SLACK_API_TOKEN=${SLACK_API_TOKEN} -e SLACK_USER=${SLACK_USER} -ti slack-pom:0.1
elif [ -f ENV ]
then
  echo "Using environment file for SLACK_API_TOKEN & SLACK_USER"
  docker run --rm --env-file ENV -ti slack-pom:0.1
else
  echo "Settings not found for SLACK_API_TOKEN & SLACK_USER"
  echo
  echo "export SLACK_API_TOKEN & SLACK_USER"
  echo
  echo "or"
  echo
  echo "add SLACK_API_TOKEN & SLACK_USER values to ENV file"
fi
