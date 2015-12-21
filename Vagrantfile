# --- configuration knobs ---
DOMAIN  = 'mclust.net'   # default domain name
MEMORY  = 1024           # default memory size
NUMCPU  = 1              # default number of CPUs
BOX     = 'puppetlabs/centos-7.0-64-puppet'
BOX_URL = ''


BOXEN = [
  {:hostname => 'mc01', :ip => '172.20.1.11', :box => BOX, :ram => MEMORY, :cpus => NUMCPU},
  {:hostname => 'mc02', :ip => '172.20.1.12', :box => BOX, :ram => MEMORY, :cpus => NUMCPU},
  {:hostname => 'mc03', :ip => '172.20.1.13', :box => BOX, :ram => MEMORY, :cpus => NUMCPU},
]


# --- vagrant configuration ---

Vagrant.configure('2') do |config|
  BOXEN.each do |node|

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = false
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.hostname = node[:hostname] + '.' + DOMAIN
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end

      memory = node[:ram] ? node[:ram] : 256;
      cpus = node[:cpus]
      node_config.vm.provider :virtualbox do |vb|
        vb.customize ['modifyvm', :id, '--name', node[:hostname]]
        vb.customize ['modifyvm', :id, '--memory', memory.to_s]
        vb.customize ['modifyvm', :id, '--cpus', cpus.to_s]
      end
    end
  end
end
