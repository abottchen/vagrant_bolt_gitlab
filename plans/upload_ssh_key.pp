plan vagrant_bolt_gitlab::upload_ssh_key(
  TargetSpec $targets,
) {
  $targets.apply_prep

  apply($targets) {
    file {'/etc/puppetlabs/puppetserver/ssh.key':
      ensure => file,
      source => 'puppet:///modules/vagrant_bolt_gitlab/ssh.key',
      owner => 'pe-puppet',
      group => 'pe-puppet',
      mode => '0640',
    }
  }
}
