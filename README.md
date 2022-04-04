# Unraid_check_docker_script
Script to troubleshoot what is filling up Unraid docker image

This script is to help troubleshoot why an Unraid docker image is getting too big.

The script when run will 
1. Show how much total space your Docker images, containers and volumes are taking up.
2. Shows how mcuh space each container is taking up (both writable layer and combined read/writable layer size)
3. Will list container size in order from highest to lowest size
4. Shows each docker volume, its size and which container it is connected to
5. Can be set to remove both orphaned images and unconnected docker volumes when run.


Usage

With user script plugin installed copy and paste script to your Unraid server.
By default script will not remove orpaned images or unconected docker volumes. Set variables to "yes" to have script remove them.
Run script and use it to find out which container or docker image is taking up too much space.
Once you find out what is the culprit check all of your docker mappings for that container. Also check inside the container (a download container like nzbget for example)
that the internal paths are set to a mapped location.
