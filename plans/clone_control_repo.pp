plan vagrant_bolt_gitlab::clone_control_repo(
  TargetSpec $gitlab,
  TargetSpec $target,
) {

  out::message("Gathering facts from gitlab server")
  $gitlab.apply_prep
  without_default_logging() || { run_plan(facts, targets => $gitlab) }
  $gitlab_facts = get_target($gitlab).facts()
  $gitlab_fqdn = $gitlab_facts['fqdn']

  $target.apply_prep
  apply($target) {
    file {'/root/.ssh/id_rsa-vagrant-bolt-gitlab':
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
          'IdentityFile'             => '/root/.ssh/id_rsa-vagrant-bolt-gitlab',
          'PreferredAuthentications' => 'publickey',
          'UserKnownHostsFile'       => '/dev/null',
          'Port'                     => '8022',
        }
      }
    }

    file { '/root/dev':
      ensure => directory,
    }

    exec {'pull control repo':
      path    => '/usr/bin',
      command => "git clone git@${gitlab_fqdn}:/root/control-repo.git /root/dev/control-repo",
      unless  => '[ -d "/root/dev/control-repo" ]',
    }

    exec {'pull module repo':
      path    => '/usr/bin',
      command => "git clone git@${gitlab_fqdn}:/root/puppetlabs-motd.git /root/dev/puppetlabs-motd",
      unless  => '[ -d "/root/dev/puppetlabs-motd" ]',
    }
  }
}
