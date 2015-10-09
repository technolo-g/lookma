# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Forward X11
  config.ssh.forward_x11 = true

  # VMware Configuration
  config.vm.provider "vmware_fusion" do |provider, override|
    override.vm.box = "vmware-xen-trusty64.box"
    override.vm.box_url = 'https://s3-us-west-2.amazonaws.com/technolo-g/vagrant-boxes/ubuntu/vmware-xen-trusty64.box'
    override.vm.box_check_update = false
  end
  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = '4096'
    v.vmx["numvcpus"] = '4'
    v.gui = true
  end

  # VirtualBox Configuration
  config.vm.provider "virtualbox" do |provider, override|
    override.vm.box = "vbox-xen-trusty64-20150509.box"
    override.vm.box_url = 'https://s3-us-west-2.amazonaws.com/technolo-g/vagrant-boxes/ubuntu/vbox-xen-trusty64-20150509.box'
    override.vm.box_check_update = false
  end
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096 
    v.cpus = 4
    v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
  end

  # Setup mounts
  # Note: This mount is only for development. It is not needed to run the examples
  config.vm.synced_folder ".", "/home/vagrant/project", type: "nfs"
  config.vm.network "private_network", ip: "10.100.199.35"

$script = <<SCRIPT
sudo perl -pi -e 's~auto eth1~iface eth1 inet manual~g' /etc/network/interfaces
sudo perl -pi -e 's~iface eth1 inet static~auto xenbr0\niface xenbr0 inet static\n      bridge_ports eth1~g' /etc/network/interfaces
sudo ifdown eth1
ifup xenbr0

sudo ntpdate -s time.nist.gov

SCRIPT

  config.vm.provision "shell", inline: $script, run: "always"



end
