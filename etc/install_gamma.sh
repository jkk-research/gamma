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
git clone https://github.com/jkk-research/wayp_plan_tools -b ros2  ## waypoint following  and control TODO: update to gamma branch
git clone https://github.com/jkk-research/sim_wayp_plan_tools -b ros2 ## simulator TODO: update to gamma branch
git clone https://github.com/jkk-research/patchwork-plusplus-ros -b ROS2 # ground filter
git clone https://github.com/jkk-research/lidar_cluster_ros2 -b ros2 # cluster


echo ""
echo "++++ install gazebo ignition fortress ++++"
echo ""

cd ~/gamma_ws
source ~/.bashrc
colcon build --symlink-install --packages-select gamma_bringup  lidar_cluster  patchworkpp  sim_wayp_plan_tools  time_utils  wayp_plan_tools

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
echo "++++ install script end ++++"
echo ""