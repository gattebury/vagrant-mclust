# --- configuration knobs ---
DOMAIN  = "mclust.net"  # default domain name
MEMORY  = 1024          # default memory size
NUMCPU  = 1             # default number of CPUs
#BOX     = "puppetlabs/centos-7.0-64-puppet"
BOX     = "ubuntu/trusty64"
BOX_URL = ""
NETWORK = "172.21.1."   # net prefix


# --- vagrant configuration ---

Vagrant.configure("2") do |config|

    # hostmanager plugin
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = false
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    # head node
    config.vm.define :head do |node_config|
        node_config.vm.box = BOX
        node_config.vm.hostname = "head" + "." + DOMAIN
        node_config.vm.network :private_network, ip: NETWORK + "10"
        node_config.vm.provider :virtualbox do |vb|
            vb.memory = "1024"
            vb.cpus = "2"
        end
        node_config.vm.provision :shell, path: "bootstrap-head.sh"
    end

    # load balancer
    config.vm.define :lb do |lb_config|
        lb_config.vm.box = BOX
        lb_config.vm.hostname = "lb" + "." + DOMAIN
        lb_config.vm.network :private_network, ip: NETWORK + "9"
        lb_config.vm.network "forwarded_port", guest: 80, host: 8080
        lb_config.vm.provider :virtualbox do |vb|
            vb.memory = "1024"
        end
    end

    # worker nodes
    # https://docs.vagrantup.com/v2/vagrantfile/tips.html
    (1..2).each do |i|
        config.vm.define "node#{i}" do |node|
            node.vm.box = BOX
            node.vm.hostname = "node#{i}" + "." + DOMAIN
            node.vm.network :private_network, ip: NETWORK + "2#{i}"
            node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
            node.vm.provider :virtualbox do |vb|
                vb.memory = "1024"
            end
        end
    end

end
