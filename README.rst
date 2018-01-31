slack-pom
=========

.. image:: https://travis-ci.org/paulwilljones/slack-pom.svg?branch=master
  :target: https://travis-ci.org/paulwilljones/slack-pom

.. image:: https://quay.io/repository/paulwilljones/slack-pom/status
  :target: https://quay.io/repository/paulwilljones/slack-pom

* Build the image:
    `docker build -t slack-pom:0.1 .`

* Run the container with ENV file:
    `docker run --rm --env-file ENV -ti slack-pom`

* Run the container with ENV variables:
    `docker run --rm -e SLACK_API_TOKEN=${SLACK_API_TOKEN} -e SLACK_USER=${SLACK_USER} -ti slack-pom`
