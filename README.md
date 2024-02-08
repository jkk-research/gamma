# Gamma project instructions

## One-liner install

``` bash
cd ~ ; rm install_gamma.sh; wget https://raw.githubusercontent.com/jkk-research/gamma/main/etc/install_gamma.sh; sudo chmod +x install_gamma.sh; ./install_gamma.sh force
```

<details>
<summary>Info</summary>

This will create an `install_gamma.sh` shell script, a workspace, clone repos, install a simulator and build the packages. The `force` option removes the previous workspace.
``` bash
./install_gamma.sh force
```
``` bash
./install_gamma.sh
```
</details>

## Step-by-step install

[![Static Badge](https://img.shields.io/badge/ROS_2-Humble-34aec5)](https://docs.ros.org/en/humble/)

<details>
<summary>Create your workspace</summary>

```
mkdir -p ~/gamma_ws/src
```
You can use different name (in step-by-step install) 
</details>


<details>
<summary>Clone repos</summary>
    
- https://github.com/jkk-research/jkk_utils : `gamma_bringup`, teleop and other utiltiy packages
- https://github.com/jkk-research/wayp_plan_tools : waypoint following  and control
- https://github.com/jkk-research/sim_wayp_plan_tools : simulator (gamma branch)
- https://github.com/jkk-research/patchwork-plusplus-ros : ground filter
- https://github.com/jkk-research/lidar_cluster_ros2 : cluster, object detection
- https://github.com/jkk-research/komondor_sensors : private (hidden) 3D and sensory data
</details>


<details>
<summary>Build ROS 2 packages</summary>

```
cd ~/gamma_ws
colcon build --symlink-install --packages-select gamma_bringup  lidar_cluster  patchworkpp  sim_wayp_plan_tools  time_utils  wayp_plan_tools

``` 
</details>


<details>
<summary>Install the simulator</summary>

Gazebo ignition fortress can be installed from the insructions here: https://gazebosim.org/docs/fortress/install_ubuntu 
Also a TLDR install is here:

```
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
``` 
</details>