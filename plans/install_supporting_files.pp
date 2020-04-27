plan vagrant_bolt_gitlab::install_supporting_files(
  TargetSpec $targets,
) {
  $targets.apply_prep
  apply($targets) {
    $backup = '1588027869_2020_04_27_12.10.1_gitlab_backup.tar'
    file{"/tmp/etc.tar.gz":
      ensure => file,
      source => "puppet:///modules/vagrant_bolt_gitlab/etc.tar.gz",
    }
    file{"/var/lib/docker/volumes/gitlab_opt/_data/backups/${backup}":
      ensure => file,
      source => "puppet:///modules/vagrant_bolt_gitlab/${backup}",
      owner => 998,
      group => 998,
    }
  }

  run_task('vagrant_bolt_gitlab::extract_supporting_files', $targets)
}
