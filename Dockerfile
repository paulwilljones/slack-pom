FROM python:alpine

# Note:
#
#  Required ENVIRONMENT variables are SLACK_API_TOKEN & SLACK_USER
#
#  Create your legacy TOKEN here - https://api.slack.com/custom-integrations/legacy-tokens
#
#  Get your Slack user name from the end of the resulting URL - https://hod-dsp.slack.com/messages
#

LABEL "Source repo"="https://github.com/paulwilljones/slack-pom"
LABEL "Run with ENV file"="docker run --rm --env-file ENV -ti slack-pom:0.1"
LABEL "Run with ENV variables"="docker run --rm -e SLACK_API_TOKEN=\${SLACK_API_TOKEN} -e SLACK_USER=\${SLACK_USER} -ti slack-pom:0.1"

RUN mkdir /app
WORKDIR /app

COPY requirements.txt .
COPY slack-pom.py .

RUN pip install -r requirements.txt

# USER slack

ENTRYPOINT ./slack-pom.py
