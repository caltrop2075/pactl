#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# custom pulse audio status
#===============================================================================
BEGIN {
   FS=":"
   f=0
   o=0
   w=15                                            # first col width
}
#===============================================================================
{
   gsub(/\t/,"")                                   # remove tabs
   gsub(/  /," ")                                  # remove multi-spaces
   gsub(/  /," ")
   gsub(/  /," ")
   sub(/: /,":")
   sub(/ = /,":")                                  # change separators to :
   switch($2)                                      # only print these
   {
      case "alsa_output.pci-0000_00_1f.3.hdmi-stereo" :
      case "alsa_output.pci-0000_00_1f.3.analog-stereo" :
         f=1
   }
   if($1=="Formats")
         f=0
   if(f)
   {
      if(o)                                      # display more trailing lines
      {
         printf("%"w-1"s%s\n","",$1)
         o-=1
      }
      else
         switch($1)
         {
            case "Name" :
            case "Description" :
            case "Active Port" :
               printf("%-"w"s%s\n",$1,$2)
               break
            case "Volume" :
               printf("%-"w"s",$1)
               n=split($0,a,"[:,]")
               for(i=2;i<n;i++)
                  switch(i)
                  {
                     case 2 :
                        printf("%-11s ",a[i])
                        break
                     case 4 :
                        printf("%"w-1"s%-11s ","",a[i])
                        break
                     case 3 :
                     case 5 :
                        printf("%s\n",a[i])
                  }
               printf("%s\n",a[n])
               o=1                               # print more lines
               break
         }
   }
}
#===============================================================================
END {
}
#===============================================================================
# functions
#===============================================================================
