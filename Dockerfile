FROM python:3.6.4-alpine3.7

# Note:
#
#  Required ENVIRONMENT variables are SLACK_API_TOKEN & SLACK_USER
#
#  Create your legacy TOKEN here - https://api.slack.com/custom-integrations/legacy-tokens
#
#  Get your Slack user name from the end of the resulting URL - https://hod-dsp.slack.com/messages
#

LABEL "Source repo"="https://github.com/paulwilljones/slack-pom"
LABEL "Run with ENV file"="docker run -d --rm --name slack-pom --env-file ENV -ti quay.io/paulwilljones/slack-pom"
LABEL "Run with ENV variables"="docker run -d --rm --name slack-pom -e SLACK_API_TOKEN=\${SLACK_API_TOKEN} -e SLACK_USER=\${SLACK_USER} -ti quay.io/paulwilljones/slack-pom"

RUN mkdir /app
WORKDIR /app

COPY requirements.txt .
COPY slack-pom.py .

RUN pip install -r requirements.txt

# USER slack

ENTRYPOINT ./slack-pom.py
