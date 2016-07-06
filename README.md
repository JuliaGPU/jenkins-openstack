# Scripts to manage a Jenkins installation on OpenStack
This requires the openstackclient packages to be installed

Provison a build box with the following command (note: this is for the MIT OpenSTACK infrastucture)
```bash
nova boot --image "Ubuntu-14.04LTS-amd64" --key-name $KEY --availability-zone nova --flavor "s1.4core" --nic net-name=inet --user-data jenkins-build.sh "JenkinsBuild"
```

You can get a log of the process with `nova console-log JenkinsBuild`

# Turning this into a image for Jenkins
```bash
# Shutdown before creating an image
nova stop JenkinsBuild

# rember the id of the last image
PREVIOUS_ID=`openstack image list --property name=jenkins-build -f value -c ID`

# Create snapshot
nova image-create --poll JenkinsBuild jenkins-build

# Delete old image
# Before this step all previous instances launched based on this image need to be terminated
SERVERS=`openstack server list --image ${PREVIOUS_ID} -f value -c ID`
openstack server delete ${SERVERS}
openstack image delete ${PREVIOUS_ID}

# Delete instace
nova delete JenkinsBuild
```

