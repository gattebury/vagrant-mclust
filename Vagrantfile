
domain = 'mclust.net'

puppet_nodes = [
  {:hostname => 'head',  :ip => '172.20.1.11', :box => 'puppetlabs/centos-6.6-64-puppet', :fwdhost => 8140, :fwdguest => 8140, :ram => 1024},
  {:hostname => 'work1', :ip => '172.20.1.12', :box => 'puppetlabs/centos-6.6-64-puppet', :ram => 512},
  {:hostname => 'work2', :ip => '172.20.1.13', :box => 'puppetlabs/centos-6.6-64-puppet', :ram => 512},
]

Vagrant.configure("2") do |config|
  puppet_nodes.each do |node|

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = false
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.hostname = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip]

      if node[:fwdhost]
        node_config.vm.network :forwarded_port, guest: node[:fwdguest], host: node[:fwdhost]
      end

      memory = node[:ram] ? node[:ram] : 256;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', memory.to_s
        ]
      end
    end
  end
end
