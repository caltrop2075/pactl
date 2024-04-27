# pactl
pactl audio control

lspactl.awk
--------------------------------------------------------------------------------
list pactl

lspactl.sh
--------------------------------------------------------------------------------
list pactl

pactl-o.awk
--------------------------------------------------------------------------------
pactl list

pactl-o.sh
--------------------------------------------------------------------------------
list pactl sinks

pactl-z.sh
--------------------------------------------------------------------------------
zenity dialog to select pulse audio output
quick & easy switching of equipment
   what took 9 clicks is 3 clicks, can use keyboard too
and this works with mate panel app launcher as well as in a terminal
   running in a terminal gives pulse audio status
my system
    speaker     internal laptop
    hdmi        external monitor
    headphones  vga tv

variables, easier than index numbers, sink numbers always change
use pactl list... to find this data
new listing utility: lspactl.sh

pactl.awk
--------------------------------------------------------------------------------
custom pulse audio status

pactl.sh
--------------------------------------------------------------------------------
terminal dialog to select pulse audio output
quick & easy switching of equipment
this does not work well with mate panel app launcher

variables, easier than index numbers, sink numbers always change
use pactl list... to find this data
new listing utility: lspactl.sh

thx.sh
--------------------------------------------------------------------------------
random clip player for startup
started out as THX only but can add more
sets volume level to 33%

2024-03-23 added audio blips & functions, audio doesn't show in bar...

xrandr.awk
--------------------------------------------------------------------------------

xrandr.sh
--------------------------------------------------------------------------------
highest monitor
   $?
    0     error
    1     Internal
    2     HDMI
    3     VGA
