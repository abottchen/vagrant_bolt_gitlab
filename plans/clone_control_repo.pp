plan vagrant_bolt_gitlab::clone_control_repo(
  String[1] $gitlab,
  TargetSpec $targets,
) {

  $targets.apply_prep
  apply($targets) {
    $keypath = '/root/.ssh/id_rsa-vagrant-bolt-gitlab'
    file {$keypath:
      ensure => file,
      source => 'puppet:///modules/vagrant_bolt_gitlab/ssh.key',
      owner  => 'root',
      group  => 'root',
      mode   => '0600',
    }

    ssh::client::config::user { 'root':
      ensure        => present,
      user_home_dir => '/root',
      options       => {
      "Host ${gitlab}.*" =>
        {
          'HashKnownHosts'           => 'yes',
          'User'                     => 'git',
          'StrictHostKeyChecking'    => 'no',
          'IdentityFile'             => $keypath,
          'PreferredAuthentications' => 'publickey',
          'UserKnownHostsFile'       => '/dev/null',
          'Port'                     => '8022',
        }
      }
    }

    file { '/root/dev':
      ensure => directory,
    }

    package {'git':
      ensure => present,
    }

    exec {'pull control repo':
      path    => '/usr/bin',
      command => "bash -c \"/usr/bin/git clone git@${gitlab}:/root/control-repo.git /root/dev/control-repo\"",
      unless  => '[ -d "/root/dev/control-repo" ]',
      require => [File[$keypath], Ssh::Client::Config::User['root'], Package['git']]
    }

    exec {'pull module repo':
      path    => '/usr/bin',
      command => "bash -c \"/usr/bin/git clone git@${gitlab}:/root/puppetlabs-motd.git /root/dev/puppetlabs-motd\"",
      unless  => '[ -d "/root/dev/puppetlabs-motd" ]',
      require => [File[$keypath], Ssh::Client::Config::User['root'], Package['git']]
    }
  }
}
