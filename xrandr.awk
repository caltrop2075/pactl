#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
#===============================================================================
BEGIN {
}
#===============================================================================
{
   if(NR>1)
      if(match($1,/^[A-Za-z]+/) && $2=="connected")
         {
            switch($1)
            {
               case "eDP-1" :
                  e=1;s=$1" Internal"
                  break
               case "HDMI-1" :
                  e=2;s=$1" HDMI"
                  break
               case "DP-3" :
                  e=3;s=$1" VGA"
                  break
               default:
                  e=0
            }
         }
}
#===============================================================================
END {
   printf("%s\n",s)
   exit e
}
#===============================================================================
# functions
#===============================================================================
