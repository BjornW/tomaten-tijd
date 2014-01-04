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
spd-say --pitch -90 --rate -30 --voice-type male1 "Start Tomaaten Zeit."
notify-send --urgency=normal --icon=#PWD#/icon/tomaten-tijd/tomato-jose-campos-thenoun-project-cc-by.svg "Tomaten Tijd" "25 min om te werken";
sleep 25m 
notify-send --urgency=normal --icon=#PWD#/icon/tomaten-tijd/tomato-jose-campos-thenoun-project-cc-by.svg "Tomaten Tijd" "Tijd voor een korte pauze, start daarna Tomaten Tijd weer.";
spd-say --pitch -90 --rate -30 --voice-type male1 "Tomaaten Zeit. Take a break."
