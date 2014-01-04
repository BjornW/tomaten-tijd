#!/bin/bash 
echo -e "Checking for Tomaten-Tijd dependencies (spd-say and notify-send)..."

SPD_SAY=`locate spd-say`
if [ $? -eq 1 ] 
then 
  echo -e "Sorry, can't find spd-say, please install it and run install.sh again"
  exit -1
fi


NOTIFY_SEND=`locate notify-send`
if [ $? -eq 1 ]
then 
  echo -e "Sorry, can't find notify-send, please install it and run install.sh again"
  exit -1
fi

echo -e "Dependencies met. Continuing\n"
sleep 2s
echo -e "Setting paths for tomaten-tijd.sh and tomaten-tijd.desktop files correctly"
TOMATEN_TIJD_PATH=`pwd`
echo -e "Using tomaten-tijd path: $TOMATEN_TIJD_PATH\n"
sed -i "s:#PWD#:$TOMATEN_TIJD_PATH:g" tomaten-tijd.desktop
sed -i "s:#PWD#:$TOMATEN_TIJD_PATH:g" tomaten-tijd.sh
echo -e "Tomaten-Tijd is installed." 
echo -e "Start Tomaten-Tijd by double-clicking tomaten-tijd.desktop or use the command-line script tomaten-tijd.sh."
