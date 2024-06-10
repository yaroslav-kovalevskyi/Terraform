#!/bin/bash

# installing & configuring docker

curl -fsSL https://get.docker.com -o install-docker.sh
sh install-docker.sh
groupadd docker
usermod -aG docker ubuntu
newgrp docker
systemctl enable docker.service
systemctl enable containerd.service

# cloning exporter repo

git clone https://github.com/berezhinskiy/ecoflow_exporter.git

cd ecoflow_exporter/docker-compose


docker compose up -d