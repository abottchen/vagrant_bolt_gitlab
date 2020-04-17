plan vagrant_bolt_gitlab::install_jq(
  TargetSpec $targets,
) {
  $targets.apply_prep
  apply($targets) {
    file{'/usr/local/bin/jq':
      ensure => file,
      source => 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64',
      mode => '0755',
    }
  }
}
