#!/bin/bash
# Jenkins cloud-init script that takes a fresh instance an provision
# if with a julia build enviroment. You then can bake that instance
# into an image an set Jenkins to use it.

$SSH_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMznjfEFkq4TOJYg5qA7OzfEn2vQAuUh/n8LGnvl2Xz2lLNpcXFPOFMpu0dW6EVc4u/VslWDvZwwp3sIiISoCl0J0vHcg7OImTAEXwVSW6vgtiJnLMXhTcPDxbtO4WBF82e+7WRoWdfqF+G6twqZZ8jhzMFOdR7XI/S4xE2k31DGL6ItZpvFEnWQfxCVg8DpfY3N9nV1+NLxi0bcKXfRokzG1iyeKJ/R0Dovqi/5DgkYA2uD7nnJ1EUqkDn9Vb0hX51HyU0N8tpnp+ortQFoBkDoxO/YIgEW1uGjejxOv1haoOi4NjqlVoFPkfqmiiAcxDk5Daqm915m1y3hXsoK9L ubuntu@jenkins.julia.csail.mit.edu"

$USER=jenkins
$HOMEDIR=/home/$USER

echo "Add ubunutu-toolchain-r/test"
add-apt-repository ppa:ubuntu-toolchain-r/test

echo "Update system"
apt-get update
apt-get upgrade

echo "Install packages"
apt-get install openjdk-8-jre
apt-get install build-essential git cmake m5
apt-get install gcc-5 gfortran-5

echo "Create jenkins user"
adduser --disabled-password $USER
mkdir ${HOMEDIR}/.ssh
echo $SSH_KEY > ${HOMEDIR}/.ssh/authorized_keys
chown -R ${USER}:${USER} ${HOMEDIR}/.ssh
chmod 600 ${HOMEDIR}/.ssh/authorized_keys

