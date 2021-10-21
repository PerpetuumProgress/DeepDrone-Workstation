FROM osrf/ros:melodic-desktop-full
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics



 # setup Gazebo env and update package path
ENV GAZEBO_PLUGIN_PATH=/root/gazebo/plugins
ENV GAZEBO_MODEL_PATH=/root/gazebo/models
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/gazebo/plugins

COPY ./gazebo/ /root/gazebo/
COPY ./launch/ /root/launch/

RUN ls -la /root/gazebo

RUN apt update && apt install -y vim net-tools
RUN echo "au BufEnter,BufRead *.launch set filetype=xml" >>~/.vimrc
RUN echo "au BufEnter,BufRead *.sdf set filetype=xml" >>~/.vimrc
RUN echo "au BufEnter,BufRead *.model set filetype=xml" >>~/.vimrc
RUN echo "au BufEnter,BufRead *.world set filetype=xml" >>~/.vimrc
RUN echo "set nu" >>~/.vimrc
ENV ROS_IP=10.0.0.1


