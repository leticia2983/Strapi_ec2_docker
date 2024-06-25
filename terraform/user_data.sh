#!/bin/bash
sudo apt update && sudo apt install docker.io docker-compose -y
sudo systemctl enable docker && sudo usermod -aG docker ubuntu
git clone https://github.com/leticia2983/Strapi_ec2_docker.git
cd Strapi_ec2_docker
sudo docker run -d -p 1337:1337 leticia888444/leticia_strapi:1.0.
sleep 2000
