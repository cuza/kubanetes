# -*- mode: ruby -*-
# vi: set ft=ruby :

## vagrant parameters
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
# Use this BOX bento/ubuntu-20.04
BOX = "bento/ubuntu-20.04"
##     Proxy and port
##     If you do not use proxy, leave empty what is in quotesif not use proxy
##   Examples
# PROXY_IP =  ""
# PROXY_PORT = ""
# 
## You use proxy
# PROXY_IP =  "192.0.0.1"
# PROXY_PORT = "8080"
#############################################

PROXY_IP =  "192.168.1.10"
PROXY_PORT = "3128"

#k0s 
# The minimum hardware requirements for k0s detailed below are approximations and thus results may vary.
#   ______________________________________________________________________________
#  /                       |                           |                          \
# |          Role          |    Virtual CPU (vCPU)     |       Memory (RAM)        |
#  \_______________________|___________________________|__________________________/
#  |  Controller node      |  1 vCPU (2 recommended)   |  1 GB (2 recommended)   |
#  |-----------------------|---------------------------|-------------------------|
#  |  Worker node          |  1 vCPU (2 recommended)   |  0.5 GB (1 recommended) |
#  |-----------------------|---------------------------|-------------------------|
#  |  Controller + worker  |  1 vCPU (2 recommended)   |  1 GB (2 recommended)   |
#  |_______________________|___________________________|_________________________|
#
#
# master node parameters set IP RAM and CPU
CONTROLLER_IP = "10.8.100.10"
CONTROLLER_CPU = "1"
CONTROLLER_RAM = "1024"
# node parameters set  RAM and CPU
WORKER_IP = "10.8.100."
WORKER_CPU = "1"
WORKER_RAM = "512"
# Number node create
WORKER_COUNT = 2

#id SSH  id_rsa.pub etc
SSH_PUB_KEY = "ssh-rsa Public key tucorreo@dominio.org"


## general vagrant configurations
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # config.vm.provision :shell, inline: "apk update; apk -y upgrade"
  config.vm.box = BOX
  config.vm.provision "shell", :path => "provision/provision.sh",
      env: {
        "SSH_PUB_KEY" => SSH_PUB_KEY,
        "PROXY_IP" => PROXY_IP,
        "PROXY_PORT" => PROXY_PORT
      }

  config.vm.define "controller" do |controller|
    controller.vm.hostname = "controller"
    controller.vm.network "private_network", ip: CONTROLLER_IP
    controller.vm.network  "public_network", bridge: "wlan0"
    ## Posibles provider libvirt virtualbox
    controller.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", CONTROLLER_CPU]
      vb.customize ["modifyvm", :id, "--memory", CONTROLLER_RAM]
  end
end
  # node configuration
#   (1..WORKER_COUNT).each do |i|
#     config.vm.define "worker#{i}" do |worker|
#       worker.vm.hostname = "worker#{i}"
#       worker.vm.network "private_network", ip: WORKER_IP + "#{i + 10}"
#       worker.vm.provider :virtualbox do |vb|
#         vb.customize ["modifyvm", :id, "--cpus", WORKER_CPU]
#         vb.customize ["modifyvm", :id, "--memory", WORKER_RAM]
#       end
#     end
  # end
end
