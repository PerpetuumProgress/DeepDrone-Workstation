#!/bin/bash

SBG=524172
SLG=689149

EBG=526884
ELG=687864
COUNTER=0000
echo $EBG

for  (( LG=$SLG; LG>=$ELG; LG-=250 ))
do
     
     #echo "$LG "
     for (( BG=$SBG; BG<=$EBG; BG+=350 ))
     do
	COUNTER=$((COUNTER+0001))
	Filename=$(printf "%02d" $COUNTER)
	wget -O $Filename.png "https://maps.googleapis.com/maps/api/staticmap?center=48.$LG,11.$BG&zoom=21&size=640x640&maptype=satellite&key=<API_KEY>"
        convert $Filename.png -crop 600x600+20+20 $Filename.cropped.png
     done
     echo $COUNTER
     COUNTER=0
     echo ""
done

