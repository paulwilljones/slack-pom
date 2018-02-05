#!/usr/bin/env python
import json
import os
import sys
import time

from slackclient import SlackClient


slack_token = os.environ["SLACK_API_TOKEN"]
sc = SlackClient(slack_token)
user = os.environ["SLACK_USER"]


def set_snooze(minutes=25):
    api_call = sc.api_call('dnd.setSnooze', num_minutes=minutes)
    return _process_response(api_call)


def set_pomodoro_status():
    timeLeft = 1500
    while timeLeft > 60:
        remaining = _get_remaining_pomo_duration()
        status = "Doing a Pomodoro for another {} minutes" \
            .format(remaining / 60)
        _set_status(status, ":tomato:")
        time.sleep(60)
        timeLeft -= 60


def clear_status():
    _set_status("", "")


def _process_response(api_call):
    if api_call.get('ok'):
        return api_call
    else:
        raise Exception(api_call)


def _get_remaining_pomo_duration():
    api_call = sc.api_call('dnd.info')
    return _process_response(api_call)


def _set_status(status_text, status_emoji):
    profile = json.dumps({
        "status_text": status_text,
        "status_emoji": status_emoji
    })

    api_call = sc.api_call(
        'users.profile.set',
        user=user,
        profile=profile
    )

    response = _process_response(api_call)

    return response['snooze_remaining']


def main():
    set_snooze()
    set_pomodoro_status()
    clear_status()


if __name__ == "__main__":
    sys.exit(main())
