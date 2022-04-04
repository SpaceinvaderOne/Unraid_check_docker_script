#!/bin/bash

remove_orphaned_images="no"  # select "yes" or "no" to remove any orphaned images 
remove_unconnected_volumes="no" # select "yes" or "no" to remove any unconnected volumes

# Do not make changes below this line #

echo "##################################################################################"
echo "Cleanup before starting (if requested in script)"
echo "##################################################################################"
echo
 if [ "$remove_orphaned_images" == "yes"  ] ; then
    echo "Removing orphaned images..."
    echo
    docker image prune -af
  else
    echo "Not removing orphaned images (this can be set in script if you want to)"
  fi
echo
echo "---------------------------------------------------------------------------------"
echo
if [ "$remove_unconnected_volumes" == "yes"  ] ; then
    echo "Removing unconnected docker volumes"
    echo
    docker volume prune -f
  else
    echo "Not removing unconnected docker volumes (this can be set in script if you want to)"
  fi
echo
echo "##################################################################################"
echo "List of Image, Container and docker volume size."
echo "##################################################################################"
echo
#docker system df
docker system df --format 'There are \t {{.TotalCount}} \t {{.Type}} \t taking up ......{{.Size}}'
echo
echo "##################################################################################"
echo "List of containers showing size and virtual size"
echo "##################################################################################"
echo
echo "First size is the writable layers of the container (Virtual size is writable and read only layers)"
echo
docker container ls -a --format '{{.Size}} \t Is being taken up by ......... {{.Image}}'
echo
echo "##################################################################################"
echo "List of containers in size order"
echo "##################################################################################"
echo
docker image ls --format "{{.Repository}} {{.Size}}" | \
awk '{if ($2~/GB/) print substr($2, 1, length($2)-2) *1000 "MB - " $1 ; else print $2 " - " $1 }' | \
sed '/^0/d' | \
sort -nr
echo
echo "##################################################################################"
echo "List of docker volumes, the container which they are connected to their size"
echo "##################################################################################"
echo 
volumes=$(docker volume ls  --format '{{.Name}}')
for volume in $volumes
do
name=`(docker ps -a --filter volume="$volume" --format '{{.Names}}' | sed 's/^/  /')`
size=`(du -sh $(docker volume inspect --format '{{ .Mountpoint }}' $volume) | cut -f -1)`
echo "ID" "$volume"
echo "This volume connected to" $name "has a size of" $size
echo ""
done
echo
echo "##################################################################################"
echo
echo "Done. Scroll up to view results"
exit