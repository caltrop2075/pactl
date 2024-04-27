#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# random clip player for startup
# started out as THX only but can add more
# sets volume level to 33%
#
# 2024-03-23 added audio blips & functions, audio doesn't show in bar...
#-------------------------------------------------------------------------------
source ~/data/global.dat
lvl=33
#-------------------------------------------------------------------------------
function fx_1 ()                                   # video
{
   mplayer -quiet -noborder "$1" &> /dev/null &
}
function fx_2 ()                                   # audio
{
   mplayer "$1" &> /dev/null &
}
#-------------------------------------------------------------------------------
# set audio level
pactl set-sink-volume alsa_output.pci-0000_00_1f.3.hdmi-stereo $lvl% 2> /dev/null
pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo $lvl% 2> /dev/null
notify-send -i "$i_cat" "THX" "volume set to $lvl%"

# to add more change mod number and add to case
r=$((RANDOM%9))
case $r in
   0) fx_1 "$HOME/.videos/THX I.mp4" ;;            # video
   1) fx_1 "$HOME/.videos/THX II.mp4" ;;
   2) fx_1 "$HOME/.videos/THX III.mp4" ;;
   3) fx_1 "$HOME/.videos/Universal 1.mp4" ;;
   4) fx_1 "$HOME/.videos/Universal 2.mp4" ;;
   5) fx_2 "$HOME/Sounds/WAV/S-U/Startrek.wav" ;;  # audio
   6) fx_2 "$HOME/Sounds/WAV/U-Z/Welcom98.wav" ;;
   7) fx_2 "$HOME/Music/0 Soundtracks/Kill Bill 1/16-Ironside.mp3" ;;
   8) fx_2 "$HOME/Music/Bugs/Infinite Syndrome/07-Intermission.mp3" ;;
esac
#-------------------------------------------------------------------------------
