#!/bin/bash

./ci/dev/docker-clean-images.sh
docker rmi $(docker images --format '{{.Repository}}:{{.Tag}}' |grep 'libindy')
docker rmi $(docker images --format '{{.Repository}}:{{.Tag}}' |grep 'android')
