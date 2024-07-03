echo "First arg: $1"
if [ "$1" != "force" ]
then
    echo "++++ standard gamma install settings ++++"
else
    echo "!!!! force install settings !!!!"
    sleep 2
    if test -d ~/gamma_ws/
    then
        rm -rf ~/gamma_ws/
    fi
fi

echo "++++ install script start ++++"
echo ""


echo ""
echo "++++ create workspace ++++"
echo ""

mkdir -p ~/gamma_ws/src

echo ""
echo "++++ clone repos ++++"
echo ""

cd ~/gamma_ws/src
git clone https://github.com/jkk-research/jkk_utils -b ros2 ## gamma_bringup and other utiltiy packages
git clone https://github.com/jkk-research/wayp_plan_tools -b gamma
git clone https://github.com/jkk-research/sim_wayp_plan_tools -b ros2 ## simulator TODO: update to gamma branch?
git clone https://github.com/jkk-research/patchwork-plusplus-ros -b ROS2 # ground filter
git clone https://github.com/jkk-research/lidar_cluster_ros2 -b ros2 # cluster


echo ""
echo "++++ install gazebo ignition fortress ++++"
echo ""

cd ~/gamma_ws
source ~/.bashrc
colcon build --symlink-install --packages-select gamma_bringup lidar_cluster patchworkpp sim_wayp_plan_tools time_utils wayp_plan_tools pointcloud_manager



echo ""
echo "++++ install gazebo ignition fortress ++++"
echo ""

sudo apt-get update -y
sudo apt-get install lsb-release wget gnupg -y

sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update -y
sudo apt-get install ignition-fortress -y
sudo apt install ros-humble-foxglove-bridge -y
sudo apt install ros-humble-rosbag2-storage-mcap ros-humble-rosbag2 -y
sudo apt install ros-humble-ros-gz -y
sudo apt install mc -y


echo ""
echo "++++ install PyQtGraph ++++"
echo ""
## PyQtGraph
pip install pyqtgraph
cd ~/gamma_ws
source ~/.bashrc
colcon build --symlink-install --packages-select gui_lexus



echo ""
echo "++++ install DURO GPS ++++"
echo ""
## DURO GPS
sudo apt-get install build-essential pkg-config cmake doxygen check
cd ~; mkdir git; cd git     # eg create a git folder, the folder name can be different
git clone https://github.com/swift-nav/libsbp.git
cd libsbp
git checkout e149901e63ddcdb0d818adcd8f8e4dbd0e2738d6 
cd c
git submodule update --init --recursive
mkdir build; cd build
cmake ../
make
sudo make install

echo ""
echo "++++ install Kvaser CAN  ++++"
echo ""
## Kvaser CAN 
sudo apt-add-repository ppa:astuff/kvaser-linux 
sudo apt update -y
sudo apt install kvaser-canlib-dev kvaser-drivers-dkms -y
sudo apt install apt-transport-https -y
sudo sh -c 'echo "deb [trusted=yes] https://s3.amazonaws.com/autonomoustuff-repo/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/autonomoustuff-public.list'
sudo apt update -y
sudo apt install ros-$ROS_DISTRO-kvaser-interface -y


echo ""
echo "++++ install script end ++++"
echo ""