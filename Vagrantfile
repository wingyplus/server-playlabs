# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "chef/centos-7.0"
  config.vm.box_check_update = false

  [
    {
      :name => "production",
      :ip => "192.168.33.10"
    },
    {
      :name => "uat",
      :ip => "192.168.33.11"
    }
  ].each do |machine|
    config.vm.define machine[:name] do |stage|
      stage.vm.provider "virtualbox" do |v|
        v.name = machine[:name]
      end
      stage.vm.network "private_network", ip: machine[:ip]
    end
  end
end
