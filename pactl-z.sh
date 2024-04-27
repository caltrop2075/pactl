#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# zenity dialog to select pulse audio output
# quick & easy switching of equipment
#    what took 9 clicks is 3 clicks, can use keyboard too
# and this works with mate panel app launcher as well as in a terminal
#    running in a terminal gives pulse audio status
# my system
#     speaker     internal laptop
#     hdmi        external monitor
#     headphones  vga tv
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

# volume %
lvl=33

# current output
out=$(pactl-o.sh)

# zenity dialog
# unfortunately there is no --geometry or --position
# pops up smack in the middle of the screen
# you can change the width & height...
q=$(zenity --list \
   --width=200 --height=160 \
   --title="Pulse Audio Output" \
   --text="curr: $out" \
   --hide-header \
   --column="Hardware" \
   Speaker HDMI Headphone)
e=$?                          # error level: 0=OK, 1=CANX
case $e in                    # process zenity results
   "0")
      if [[ $q != "" ]]       # test for blank list results, ie OK w/no choice
      then
         case $q in
            "Speaker")
               pactl set-card-profile $crd1 $int
               pactl set-sink-port $snk1 $prt1
               x=322
               xrandr.sh > /dev/null  # get display config: 1 int, 2 hdmi, 3 vga
               e=$?
               if ((e==1))
               then
                  y=189
               else
                  y=501
               fi
               ;;
            "HDMI")
               pactl set-card-profile $crd1 $ext
               x=1965;y=345
               ;;
            "Headphone")
               pactl set-card-profile $crd1 $int
               pactl set-sink-port $snk1 $prt2
               x=3885;y=345
               ;;
         esac
         # set volume level
         pactl set-sink-volume $snk1 $lvl% 2> /dev/null
         pactl set-sink-volume $snk2 $lvl% 2> /dev/null
         # test video
         mplayer -quiet -noborder /home/caltrop/.videos/THX.mp4 &> /dev/null &
         # move to monitor associated with output
         sleep 0.5
         wmctrl -Fr "MPlayer" -e 0,$x,$y,-1,-1
         # pusle audio status
         pactl list sinks | pactl.awk > ~/data/title.dat
         # draws border around title.dat
         title.sh -t line
         # use what icon you want
         notify-send -i "$i_cat" "THX" "    volume: $lvl%\nhardware: $q"
      else
         echo "NO CHOICE"
      fi
      ;;
   "1")
      echo "CANX"
      ;;
   * )
      echo "ERROR"
esac
#-------------------------------------------------------------------------------
