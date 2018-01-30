FROM python:alpine

# Note:
#
#  Required ENVIRONMENT variables are SLACK_API_TOKEN & SLACK_USER
#
#  Create your legacy TOKEN here - https://api.slack.com/custom-integrations/legacy-tokens
#  
#  Get your Slack user name from the end of the resulting URL - https://hod-dsp.slack.com/messages
#

RUN mkdir /app
WORKDIR /app

COPY requirements.txt .
COPY slack-pom.py .

RUN pip install -r requirements.txt

# USER slack

ENTRYPOINT ./slack-pom.py
