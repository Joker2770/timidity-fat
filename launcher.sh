#
#    This is a launch script.
#    Copyright (C) 2021-2022 Jintao Yang <yjt950840@outlook.com>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License Version 2
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#    launcher.sh:
#       launch script.
#       launch GUI program by calling zenity on Linux.
#

#!/bin/sh

xhost +

# SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

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
  PROCESS=$(zenity --width=550 --height=310 --list \
    --title="Choose the soundfont to launch" \
    --column="cfg name" --column="Description" \
    freepats "Free patch set for MIDI audio synthesis" \
    fluidr3_gm "Fluid (R3) General MIDI SoundFont (GM)" \
    fluidr3_gs "Fluid (R3) General MIDI SoundFont (GS)" \
    ms_general "General SoundFont from MuseScore (uncompressed)" \
    opl3 "OPL3 SoundFont that simulates the sound of an OPL3 chip" \
    timgm6mb "TimGM6mb SoundFont from MuseScore 1.3" )
  RET=$?
  echo $RET
  if [ "$RET" -eq 0 ]
  then
    if [ "$PROCESS" != "" ]; then
      cd "$HOME"
      $SNAP/usr/local/bin/timidity -$GUI_INTERFACE -c $SNAP/etc/timidity/$PROCESS.cfg
    fi
  fi
done
