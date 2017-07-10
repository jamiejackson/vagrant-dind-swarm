# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.hostname = "swarm-dind"
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :private_network, ip: "192.168.56.111"
  config.vbguest.auto_update = false
  
  # Set variables for use in provisioning
  vm_temp_dir = "/vagrant/temp"
  host_temp_dir = "temp"
  host_script_dir = "scripts"
  vm_script_dir = "/vagrant/scripts"
  host_provisioned_dir = "#{host_temp_dir}/provisioned"
  vm_provisioned_dir = "#{vm_temp_dir}/provisioned"
  
  
  config.vm.provision "docker" do |d|
    # don't do anything, just install docker
  end
  
    config.vm.provision "install_docker_compose",
        type: "shell",
        path: "#{host_script_dir}/docker/install_docker_compose.sh",
        args: [
          "--compose-version=1.13.0",
          "--provisioned-dir=#{vm_provisioned_dir}",
          "--runfile-name=install_docker_compose",
          "--script-dir=#{vm_script_dir}"
        ]
  
end
