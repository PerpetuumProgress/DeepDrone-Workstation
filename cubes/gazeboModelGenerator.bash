#!/bin/bash


FILES=$(ls textures)
mapfile -t FILES < <(ls textures)
COUNTER=0

while IFS= read -r line; 
do
	filename=$(echo "${FILES[$COUNTER]}" | cut -d . -f1)
	#change model name

        #30x30
        mkdir ../gazebo/models/virtual_obstacles/30x30/${line// /_}
        cp 30x30template/* ../gazebo/models/virtual_obstacles/30x30/${line// /_}
	sed -i -e "s/MODEL_NAME/${line// /_}/g" ../gazebo/models/virtual_obstacles/30x30/${line// /_}/model.sdf
	sed -i -e "s/VO/${line// /_}/g" ../gazebo/models/virtual_obstacles/30x30/${line// /_}/model.sdf
	sed -i -e "s/OBJECTNAME/$line/g" ../gazebo/models/virtual_obstacles/30x30/${line// /_}/model.config
	sed -i -e "s/placeholder/$filename/g" ../gazebo/models/virtual_obstacles/30x30/${line// /_}/vo30x30.dae
	cp textures/${FILES[$COUNTER]} ../gazebo/models/virtual_obstacles/30x30/${line// /_}/
	

	#50x50
        mkdir ../gazebo/models/virtual_obstacles/50x50/${line// /_}
        cp 50x50template/* ../gazebo/models/virtual_obstacles/50x50/${line// /_}
	sed -i -e "s/MODEL_NAME/${line// /_}/g" ../gazebo/models/virtual_obstacles/50x50/${line// /_}/model.sdf
	sed -i -e "s/VO/${line// /_}/g" ../gazebo/models/virtual_obstacles/50x50/${line// /_}/model.sdf
	sed -i -e "s/OBJECTNAME/$line/g" ../gazebo/models/virtual_obstacles/50x50/${line// /_}/model.config
	sed -i -e "s/placeholder/$filename/g" ../gazebo/models/virtual_obstacles/50x50/${line// /_}/vo50x50.dae
	cp textures/${FILES[$COUNTER]} ../gazebo/models/virtual_obstacles/50x50/${line// /_}/
	
	
	#100x100
        mkdir ../gazebo/models/virtual_obstacles/100x100/${line// /_}
        cp 100x100template/* ../gazebo/models/virtual_obstacles/100x100/${line// /_}
	sed -i -e "s/MODEL_NAME/${line// /_}/g" ../gazebo/models/virtual_obstacles/100x100/${line// /_}/model.sdf
	sed -i -e "s/VO/${line// /_}/g" ../gazebo/models/virtual_obstacles/100x100/${line// /_}/model.sdf
	sed -i -e "s/OBJECTNAME/$line/g" ../gazebo/models/virtual_obstacles/100x100/${line// /_}/model.config
	sed -i -e "s/placeholder/$filename/g" ../gazebo/models/virtual_obstacles/100x100/${line// /_}/vo100x100.dae
	cp textures/${FILES[$COUNTER]} ../gazebo/models/virtual_obstacles/100x100/${line// /_}/


	echo $line
	echo ""
        ((COUNTER++))

done < virtual_obstacles
