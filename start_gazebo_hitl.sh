# If not working, first do: sudo rm -rf /tmp/.docker.xauth
# It still not working, try running the script as root.

XAUTH=/tmp/.docker.xauth

echo "Preparing Xauthority data..."
xauth_list=$(xauth nlist :0 | tail -n 1 | sed -e 's/^..../ffff/')
if [ ! -f $XAUTH ]; then
    if [ ! -z "$xauth_list" ]; then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

pRosMasterUri="10.0.0.5"

while getopts c:w:m: flag
do
    case "${flag}" in
        c) pCamera=${OPTARG};;
	w) pWorld=${OPTARG};;
	m) pRosMasterUri=${OPTARG};;
	*) echo "Supported options are:"
	   echo "-c select the camera you want to use: depth or stereo"
	   echo "-w select the world: simple_obstacle or manching_airport"
	   exit;;
    esac
done



#Vaidate user input for camera
case "${pCamera}" in
	stereo) camera="stereo"
		echo "hitl stereo camera selected " ;;
	depth) camera="depth"
		echo "hitl depth camera selected" ;;
	*) echo "-c flag missing. No valid camera information given. Please provide one of the following options: stereo or depth"
	   exit;;
esac

#Vaidate user input for wolrd
case "${pWorld}" in
        simple_obstacle) world="simple_obstacle"
                echo "Simple Obstacle World selected " ;;
        manching_airport) world="manching_airport"
                echo "Manching Airport world selected" ;;
        drone_center) world="drone_center"
		echo "drone Center is selected";;
        *) echo "-w flag missing. No valid world information given. Please provide one of the following options: manching_airport or simple_obstacle"
           exit;;
esac


#rosIp=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')
rosIp="10.0.0.1"
echo "ROS_IP=${rosIP}"

echo "Done."
echo ""
echo "Verifying file contents:"
file $XAUTH
echo "--> It should say \"X11 Xauthority data\"."
echo ""
echo "Permissions:"
ls -FAlh $XAUTH
echo ""
echo "Running docker..."
world_path="/root/src/sitl_gazebo/worlds/${world}_${camera}.world"
echo $world_path

docker run -it --rm\
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="$HOME:$HOME" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --device="/dev/ttyACM0" \
    --env="XAUTHORITY=$XAUTH" \
    --env="ROS_IP=10.0.0.1" \
    --volume="$XAUTH:$XAUTH" \
    --volume=$(pwd)/launch:/root/launch\
    --network host\
    --privileged \
    spokorny/ddc:workstation \
    roslaunch /root/launch/gazebo_hitl_iris.launch world_path:=$world_path

echo "Done."
