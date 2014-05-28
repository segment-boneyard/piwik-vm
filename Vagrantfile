
Vagrant.configure('2') do |conf|
  conf.vm.box = 'precise64'
  conf.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  conf.vm.network :forwarded_port, host: 5000, guest: 80
  conf.vm.provision :shell, path: 'setup.sh'
end
