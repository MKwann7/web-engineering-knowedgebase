#! /bin/bash

clear
reset

BUILD=local
APP_NAME=knowledgebase

project_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "project_path = ${project_path}"

docker rmi $(docker images -f "dangling=true" -q) 2> /dev/null

docker-compose -f docker/docker-compose.local.yml up --build