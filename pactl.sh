#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# terminal dialog to select pulse audio output
# quick & easy switching of equipment
# this does not work well with mate panel app launcher
#
# variables, easier than index numbers, sink numbers always change
# use pactl list... to find this data
# new listing utility: lspactl.sh
#-------------------------------------------------------------------------------
crd1="alsa_card.pci-0000_00_1f.3"
crd2="alsa_card.usb-046d_08d7-01"
int="output:analog-stereo+input:analog-stereo"
ext="output:hdmi-stereo+input:analog-stereo"
prt1="analog-output-speaker"
prt2="analog-output-headphones"

# no list for this...
snk1="alsa_output${crd1#alsa_card}.analog-stereo"
snk2="alsa_output${crd1#alsa_card}.hdmi-stereo"

# dialog
title-80.sh -t line "Pulse Audio Select"
PS3="? "
select opt in "exit" "speaker" "hdmi" "headphone"
do
   case $opt in
      "speaker")
         pactl set-card-profile 1 $int
         pactl set-sink-port $snk1 $prt1
         break ;;
      "hdmi")
         pactl set-card-profile 1 $ext
         break ;;
      "headphone")
         pactl set-card-profile 1 $int
         pactl set-sink-port $snk1 $prt2
         break ;;
      "exit")
         echo -e "\nexit"
         # exit
         break ;;
      *)
         echo -e ">>>err<<<" ;;
   esac
done
echo -e "$div_s"
pactl list sinks | pactl.awk
echo -e "$div_s\nrunning test"
thx.sh
#-------------------------------------------------------------------------------
