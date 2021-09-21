#!/bin/bash

sudo sed -i 's/archive.ubuntu.com/repos.uclv.edu.cu/' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/repos.uclv.edu.cu/' /etc/apt/sources.list


# Add authorized_keys 
echo "${ssh_rsa}" >> /home/vagrant/.ssh/authorized_keys

### Check if PROXY_Ip is NULL

if [ ! -n "${PROXY_IP}" ]
then
	echo "Not use proxy"
else
	sudo bash -c cat <<EOF > /etc/apt/apt.conf.d/proxy.conf
        Acquire {
        HTTP::proxy "http://${PROXY_IP}:${PROXY_PORT}";
        HTTPS::proxy "http://${PROXY_IP}:${PROXY_PORT}";
        }
EOF
sudo bash -c cat <<EOF >> /etc/environment
http_proxy="http://${PROXY_IP}:${PROXY_PORT}"
https_proxy="http://${PROXY_IP}:${PROXY_PORT}"
ftp_proxy="http://${PROXY_IP}:${PROXY_PORT}"
EOF
fi

curl -sSLf -x ${PROXY_IP}:${PROXY_PORT} https://nexus.uclv.edu.cu/repository/github.com/cuza/kubanetes/raw/main/get-k0s | sudo python3 -

