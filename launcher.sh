#!/bin/sh

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

RET=0
GUI_INTERFACE=$(zenity --list --width=350 --height=210 --radiolist \
  --title="Choose the interface" \
  --column "Select" --column="Interface" --column="Description" TRUE "ig" "Interface of GTK+" FALSE "ik" "Interface of Tcl/Tk" FALSE "im" "Interface of motif" )
RET=$?
echo $GUI_INTERFACE
if [ "$GUI_INTERFACE" = "ig" ]; then
   echo "Interface of GTK+"
elif [ "$GUI_INTERFACE" = "ik" ]; then
   echo "Interface of Tcl/Tk"
elif [ "$GUI_INTERFACE" = "im" ]; then
   echo "Interface of motif"
else
   echo "cancel"
fi

while [ $RET -eq 0 ]; do
  PROCESS=$(zenity --width=500 --height=350 --list \
    --title="Choose the soundfont to launch" \
    --column="cfg name" --column="Description" \
    freepats "Free patch set for MIDI audio synthesis" \
    fluidr3_gm "Fluid (R3) General MIDI SoundFont (GM)" \
    fluidr3_gs "Fluid (R3) General MIDI SoundFont (GS)" \
    ms_general "General SoundFont from MuseScore (uncompressed)" \
    opl3 "OPL3 SoundFont that simulates the sound of an OPL3 chip" \
    timgm6mb "TimGM6mb SoundFont from MuseScore 1.3" \
    website "https://sourceforge.net/projects/timidity/" )
  RET=$?
  echo $RET
  if [ "$RET" -eq 0 ]
  then
     if [ "$PROCESS" = "website" ]
     then
        sensible-browser "https://sourceforge.net/projects/timidity/"
     else
       if [ "$PROCESS" != "" ]; then
          cd "$SCRIPT_DIR"
          timidity -$GUI_INTERFACE -c $SNAP/etc/timidity/$PROCESS.cfg
       fi
     fi
  fi
done
