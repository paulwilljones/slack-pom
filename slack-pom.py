#!/usr/bin/env python
import json
import logging
import os
import sys
import time

from slackclient import SlackClient

logging.basicConfig(level=logging.DEBUG)

slack_token = os.environ["SLACK_API_TOKEN"]
sc = SlackClient(slack_token)
user = os.environ["SLACK_USER"]


def set_snooze(minutes=25):
    api_call = sc.api_call('dnd.setSnooze', num_minutes=minutes)
    logging.debug("dnd set for {} minutes".format(minutes))
    return _process_response(api_call)


def set_pomodoro_status():
    timeLeft = 1500
    while timeLeft > 60:
        remaining = _get_remaining_pomo_duration()
        status = "In a Pomodoro for another {:.0f} minutes" \
            .format(remaining / 60)
        _set_status(status, ":tomato:")
        logging.debug("Status set to: {}".format(status))
        time.sleep(60)
        timeLeft -= 60


def clear_status():
    _set_status("", "")
    logging.debug("Status cleared")


def set_available():
    api_call = sc.api_call(
        'users.setPresence',
        presence="auto"
    )
    logging.debug("Presence set to available")

    return _process_response(api_call)


def _process_response(api_call):
    if api_call.get('ok'):
        return api_call
    else:
        raise Exception(api_call)


def _get_remaining_pomo_duration():
    api_call = sc.api_call('dnd.info')
    response = _process_response(api_call)

    return response['snooze_remaining']


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

    return _process_response(api_call)


def main():
    set_snooze()
    set_pomodoro_status()
    clear_status()
    set_available()


if __name__ == "__main__":
    sys.exit(main())
