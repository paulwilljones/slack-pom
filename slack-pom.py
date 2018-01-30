#!/usr/bin/env python

from slackclient import SlackClient
import json
import os
import sys


slack_token = os.environ["SLACK_API_TOKEN"]
sc = SlackClient(slack_token)
user = os.environ["SLACK_USER"]


def set_snooze(minutes=25):
    api_call = sc.api_call('dnd.setSnooze', num_minutes=minutes)
    return _process_response(api_call)


def set_status(user, status='Pomming'):
    profile = json.dumps({
            "status_text": status,
            "status_emoji": ":tomato:"
    })

    api_call = sc.api_call(
        'users.profile.set',
        user=user,
        profile=profile
    )

    return _process_response(api_call)


def _process_response(api_call):
    if api_call.get('ok'):
        return api_call
    else:
        raise Exception(api_call)


def main():
    set_snooze()
    set_status(user)


if __name__ == "__main__":
    sys.exit(main())
