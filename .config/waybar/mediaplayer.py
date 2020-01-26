#!/usr/bin/env python3

import argparse
import json
import logging
import signal
import sys
from datetime import timedelta
from math import floor

# yapf: disable
import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import GLib, Playerctl
# yapf: enable

logger = logging.getLogger(__name__)


def write_output(text, player):
    logger.info('Writing output')

    output = {
        'text': text,
        'class': 'custom-' + player.props.player_name,
        'alt': player.props.player_name
    }

    sys.stdout.write(json.dumps(output) + '\n')
    sys.stdout.flush()


def on_play(player, status, manager):
    logger.info('Received new playback status')
    on_metadata(player, player.props.metadata, manager)


def on_metadata(player, metadata, manager):
    logger.info('Received new metadata')
    track_info = ''

    if player.props.player_name == 'spotify' and \
            'mpris:trackid' in metadata.keys() and \
            ':ad:' in player.props.metadata['mpris:trackid']:
        track_info = 'AD PLAYING'

    if player.get_title() and player.get_title() != '':
        track_info = f"{player.get_title()}"
    if player.get_artist() and player.get_artist() != '':
        track_info = f"{player.get_artist()} - {track_info}"

    if 'mpris:length' in player.props.metadata.keys():
        dur_td = timedelta(microseconds=player.props.metadata['mpris:length'])
        dur_h, remainder = divmod(dur_td.total_seconds(), 3600)
        dur_m, dur_s = divmod(remainder, 60)
        dur = f"{floor(dur_m)}:{floor(dur_s):02}"
        if dur_h > 0:
            dur = f"{floor(dur_h)}:{dur}"
        track_info = '{} ({})'.format(track_info, str(dur))

    if player.props.status == 'Paused' and track_info:
        track_info = ' ' + track_info

    if player.props.status == 'Stopped':
        return

    if track_info == '':
        logger.warning('TrackInfo was empty after parsing')
        return

    write_output(track_info, player)


def on_player_appeared(manager, player, selected_player=None):
    if player is not None and (selected_player is None
                               or player.name == selected_player):
        init_player(manager, player)
    else:
        logger.debug(
            "New player appeared, but it's not the selected player, skipping")


def on_player_vanished(manager, player):
    logger.info('Player has vanished')
    sys.stdout.write('\n')
    sys.stdout.flush()


def init_player(manager, name):
    logger.debug('Initialize player: {player}'.format(player=name.name))
    player = Playerctl.Player.new_from_name(name)
    player.connect('playback-status', on_play, manager)
    player.connect('metadata', on_metadata, manager)
    manager.manage_player(player)
    on_metadata(player, player.props.metadata, manager)


def signal_handler(sig, frame):
    logger.debug('Received signal to stop, exiting')
    sys.stdout.write('\n')
    sys.stdout.flush()
    # loop.quit()
    sys.exit(0)


def parse_arguments():
    parser = argparse.ArgumentParser()

    # Increase verbosity with every occurance of -v
    parser.add_argument('-v', '--verbose', action='count', default=0)

    # Define for which player we're listening
    parser.add_argument('--player',
                        help='player to listen for')

    # Define which players to ignore entirely
    parser.add_argument('-I', '--ignore',
                        action='append',
                        help='players to ignore')

    return parser.parse_args()


def main():
    arguments = parse_arguments()

    # Initialize logging
    logging.basicConfig(stream=sys.stderr,
                        level=logging.DEBUG,
                        format='%(name)s %(levelname)s %(message)s')

    # Logging is set by default to WARN and higher.
    # With every occurrence of -v it's lowered by one
    logger.setLevel(max((3 - arguments.verbose) * 10, 0))

    # Log the sent command line arguments
    logger.debug('Arguments received {}'.format(vars(arguments)))

    manager = Playerctl.PlayerManager()
    loop = GLib.MainLoop()

    manager.connect('name-appeared',
                    lambda *args: on_player_appeared(*args, arguments.player))
    manager.connect('player-vanished', on_player_vanished)

    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    for player in manager.props.player_names:
        if arguments.player is not None and arguments.player != player.name:
            logger.debug(
                '{player} is not the filtered player, skipping it'.format(
                    player=player.name))
            continue

        if arguments.ignore is not None and player.name in arguments.ignore:
            logger.debug(
                '{player} is ignored, skipping it'.format(
                    player=player.name))
            continue

        init_player(manager, player)

    loop.run()


if __name__ == '__main__':
    main()
