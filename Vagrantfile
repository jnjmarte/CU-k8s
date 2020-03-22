Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false

  config.vm.define "master-2" do |master|
    master.vm.box = "centos/7"
    master.vm.box_version = "1905.1"
    master.vm.hostname = "master-2.192.168.61.12.xip.io"
    master.vm.network "private_network", ip: "192.168.61.12"
    master.vm.provision "file", source: "./bastion/kubernetes.repo", destination: "/tmp/kubernetes.repo"
    master.vm.provision "shell", path: "./nodes/config.sh"
    master.vm.provider "virtualbox" do |v|
      v.name = "master-2-vagrant"
      v.memory = 2000
      v.cpus = 1
      v.customize [
        'modifyvm', :id,
        '--groups', '/CU-k8s/masters'
      ]
      ###
      ### Add sdb disk for Docker ###
      ###
      unless File.exists?("./volumes/master-2-docker/sdb.vdi")
        v.customize [
          'createmedium', 'disk',
          '--filename', "./volumes/master-2-docker/sdb.vdi",
          '--format', 'VDI',
          '--size', 20 * 1024
        ]
      end
      v.customize [
        'storageattach', :id,
        '--storagectl', 'IDE',
        '--port', 1,
        '--device', 0,
        '--type', 'hdd',
        '--medium', "./volumes/master-2-docker/sdb.vdi"
      ]
    end
  end


  (1..3).each do |i|
    config.vm.define "worker-#{i}" do |worker|
      worker.vm.box = "centos/7"
      worker.vm.box_version = "1905.1"
      worker.vm.hostname = "worker-#{i}.192.168.61.2#{i}.xip.io"
      worker.vm.network "private_network", ip: "192.168.61.2#{i}"
      worker.vm.provision "file", source: "./bastion/kubernetes.repo", destination: "/tmp/kubernetes.repo"
      worker.vm.provision "shell", path: "./nodes/config.sh"
      worker.vm.provider "virtualbox" do |v|
        v.name = "worker-#{i}-vagrant"
        v.memory = 1500
        v.cpus = 1
        v.customize [
          'modifyvm', :id,
          '--groups', '/CU-k8s/workers'
        ]
        ###
        ### Add sdb disk for Docker ###
        ###
        unless File.exists?("./volumes/worker-#{i}-docker/sdb.vdi")
          v.customize [
            'createmedium', 'disk',
            '--filename', "./volumes/worker-#{i}-docker/sdb.vdi",
            '--format', 'VDI',
            '--size', 20 * 1024
          ]
        end
        v.customize [
          'storageattach', :id,
          '--storagectl', 'IDE',
          '--port', 1,
          '--device', 0,
          '--type', 'hdd',
          '--medium', "./volumes/worker-#{i}-docker/sdb.vdi"
        ]
      end
    end
  end

  config.vm.define "master-1" do |bastion|
      bastion.vm.box = "centos/7"
      bastion.vm.box_version = "1905.1"
      bastion.vm.hostname = "master-1.192.168.61.11.xip.io"
      bastion.vm.network "private_network", ip: "192.168.61.11"
      bastion.vm.provision "file", source: "./bastion/password.txt", destination: "/tmp/password.txt"
      bastion.vm.provision "file", source: "./bastion/hostnames.txt", destination: "/tmp/hostnames.txt"
      bastion.vm.provision "file", source: "./bastion/kubernetes.repo", destination: "/tmp/kubernetes.repo"
      bastion.vm.provision "file", source: "./bastion/postinstall.sh", destination: "/tmp/postinstall.sh"
      bastion.vm.provision "file", source: "./ansible", destination: "/tmp/"
      bastion.vm.provision "shell", path: "./bastion/configbastion.sh"
      bastion.vm.provider "virtualbox" do |v|
        v.name = "master-1-vagrant"
        v.memory = 2000
        v.cpus = 1
        v.customize [
          'modifyvm', :id,
          '--groups', '/CU-k8s/masters'
        ]
        ###
        ### Add sdb disk for Docker ###
        ###
        unless File.exists?("./volumes/master-1-docker/sdb.vdi")
          v.customize [
            'createmedium', 'disk',
            '--filename', "./volumes/master-1-docker/sdb.vdi",
            '--format', 'VDI',
            '--size', 20 * 1024
          ]
        end
        v.customize [
          'storageattach', :id,
          '--storagectl', 'IDE',
          '--port', 1,
          '--device', 0,
          '--type', 'hdd',
          '--medium', "./volumes/master-1-docker/sdb.vdi"
        ]
      end
    end

end
