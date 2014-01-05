#!/bin/bash
# 
# Tomaten Tijd is a tiny Pomodoro technique script 
# by Bjorn Wijers <burobjorn@burobjorn.nl>
#
# Description: 
# The script starts with a notification and then sleeps for 25 minutes.
# After 25 minutes the script  will notify the user to take a break and quits itself.
# For the next Pomodoro session you'll need to start Tomaten Tijd again
#
# Dependencies: 
# notify-send
# spd-say

# See for more information on the Pomodoro Technique: 
# https://en.wikipedia.org/wiki/Pomodoro_Technique

# Feel free to change the icon or alter the messages
# but do not remove the #PWD# from the path! This is used to set the full path
# during installation by the install.sh script
readonly ICON="#PWD#/icon/tomato-jose-campos-thenoun-project-cc-by.svg"
readonly MSG_START_AUDIO="Start Tomaaten Zeit."
readonly MSG_STOP_AUDIO="Tomaaten Zeit. Take a break."
readonly MSG_TITLE_TEXT="Tomaten Tijd"
readonly MSG_START_TEXT="25 minuten aan de slag"
readonly MSG_STOP_TEXT="Korte pauze en werk notitie maken" 
readonly POMODORO_TIME=25m # do not forgot to add m for minutes or h for hours

# Do not alter stuff below this line unless you know what you do ;)
readonly APP_NAME=$(basename "$0")
readonly LOCKFILE_DIR=/var/lock
readonly LOCK_FD=200

# set a lock to prevent multiple instances to be run at the same time
lock() {
  local prefix=$1
  local fd=${2:-$LOCK_FD}
  local lock_file=$LOCKFILE_DIR/$prefix.lock

  # create lock file
  eval "exec $fd>$lock_file"
  
  # acquire lock
  flock -n $fd && return 0 || return 1
}

# before exiting, display an error message and write it to syslog
pre_exit() {
  local error_msg="$@"
  logger -s $error_msg
  exit 1
}

# First we make sure only one instance can be run at a time, by using a file lock 
# aka flock. Then we use spd-say to speak the message to the user and we will also use 
# notify-send to display a notification text. After this we wait for (by default) 
# 25 minutes and warn to user by audio and text that 25 minutes have passed. After 
# this the script will quit and you'll need to start it again for the next 25 minutes.
run() {
  lock $APP_NAME || pre_exit "$APP_NAME is already running. Only one instance of $APP_NAME is allowed to run" 
  spd-say --pitch -90 --rate -30 --voice-type male1 "$MSG_START_AUDIO"
  notify-send --urgency=normal --icon=$ICON "$MSG_TITLE_TEXT" "$MSG_START_TEXT"
  sleep $POMODORO_TIME 
  notify-send --urgency=normal --icon=$ICON "$MSG_TITLE_TEXT" "$MSG_STOP_TEXT"
  spd-say --pitch -90 --rate -30 --voice-type male1 "$MSG_STOP_AUDIO"
}
run
