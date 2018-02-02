slack-pom
=========

[![Build Status](https://travis-ci.org/paulwilljones/slack-pom.svg?branch=master)](https://travis-ci.org/paulwilljones/slack-pom)    [![Docker Repository on Quay](https://quay.io/repository/paulwilljones/slack-pom/status "Docker Repository on Quay")](https://quay.io/repository/paulwilljones/slack-pom)

* Build the image:
  `make build`

* Run the container:
    `make pomon`

* Run the container with ENV file:
    `docker run --rm --env-file ENV -it slack-pom`

* Run the container with ENV variables:
    `docker run --rm -e SLACK_API_TOKEN=${SLACK_API_TOKEN} -e SLACK_USER=${SLACK_USER} -it slack-pom`

* Clear Slack status and stop dnd:
    `make pomoff`

* Install pre-commit hooks:
    `make install-hooks`

* Run pre-commit hooks:
    `make run-hooks`

* Clean pre-commit hooks:
    `make clean-hooks`

Add the following to `~/.bashrc`:
```
export SLACK_API_TOKEN=<SLACK_API_TOKEN>
export SLACK_USER=<SLACK_USER>
alias pomon='docker run --rm -e SLACK_API_TOKEN=${SLACK_API_TOKEN} -e SLACK_USER=${SLACK_USER} -it quay.io/paulwilljones/slack-pom'
alias pomoff='curl -XPOST "https://slack.com/api/users.profile.set?token=${SLACK_API_TOKEN}&profile=%7B%22status_text%22%3A%22%22%2C%20%22status_emoji%22%3A%20%22%22%7D&user=${SLACK_USER}&pretty=1" && curl -XPOST "https://slack.com/api/dnd.endDnd?token=${SLACK_API_TOKEN}&pretty=1"'```
