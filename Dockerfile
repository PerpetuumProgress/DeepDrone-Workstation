FROM osrf/ros:melodic-desktop-full

RUN apt update -y && apt install -y \
 libgstreamer1.0-0 \
 libgstreamer-plugins-base1.0-dev\
 gstreamer1.0-plugins-base \
 gstreamer1.0-plugins-good \ 
 gstreamer1.0-plugins-bad \
 gstreamer1.0-plugins-ugly \
 gstreamer1.0-libav \
 gstreamer1.0-doc \
 gstreamer1.0-tools \ 
 gstreamer1.0-x \
 gstreamer1.0-alsa \
 gstreamer1.0-gl \
 gstreamer1.0-gtk3 \
 gstreamer1.0-qt5 \
 gstreamer1.0-pulseaudio \
 protobuf-compiler \
 ros-melodic-mavlink \
 python3-pip \
 vim \
 net-tools

RUN pip3 install -U \
 Jinja2 \
 Cython \
 numpy \
 empy \
 pyros-genmsg \
 packaging \
 toml 


RUN mkdir -p /root/src
WORKDIR /root/src
RUN git clone --recursive https://github.com/PX4/sitl_gazebo.git
RUN mkdir /root/src/sitl_gazebo/build
WORKDIR /root/src/sitl_gazebo/build

RUN cmake ..

RUN make -j$(nproc) -l$(nproc) 


ENV GAZEBO_PLUGIN_PATH=/root/src/sitl_gazebo/build
ENV GAZEBO_MODEL_PATH=/root/src/sitl_gazebo/models:/root/src/sitl_gazebo/models:/root/src/sitl_gazebo/models/virtual_obstacles/30x30:/root/src/sitl_gazebo/models/virtual_obstacles/50x50:/root/src/sitl_gazebo/models/virtual_obstacles/100x100


ENV GAZEBO_MODEL_DATABASE_URI=""


RUN echo "au BufEnter,BufRead *.launch set filetype=xml" >>~/.vimrc
RUN echo "au BufEnter,BufRead *.sdf set filetype=xml" >>~/.vimrc
RUN echo "au BufEnter,BufRead *.model set filetype=xml" >>~/.vimrc
RUN echo "au BufEnter,BufRead *.world set filetype=xml" >>~/.vimrc
RUN echo "set nu" >>~/.vimrc

COPY ./gazebo/models/ /root/src/sitl_gazebo/models/
COPY ./gazebo/worlds/ /root/src/sitl_gazebo/worlds/



