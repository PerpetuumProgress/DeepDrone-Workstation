#!/bin/bash


numberOfObstacles=149


for (( COUNTER=0; COUNTER<$numberOfObstacles; COUNTER+=2 ))
do
	Filename=$(printf "%04d" $COUNTER)
	FilenameTop=$(printf "%04d" $((COUNTER+1)))

	convert white.jpg ARUCO/jpg/aruco_$Filename.jpg white.jpg +append row1.jpg
	convert white.jpg ARUCO/jpg/aruco_$FilenameTop.jpg white.jpg +append row2.jpg
	convert row1.jpg row2.jpg blankrow.jpg blankrow.jpg -append textures/texture_$Filename.jpg
	echo $Filename
	echo $FilenameTop

done

