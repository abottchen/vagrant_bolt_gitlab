plan vagrant_bolt_gitlab::install_supporting_files(
  TargetSpec $targets,
) {
  $targets.apply_prep
  apply($targets) {
    ['etc_data.tar.gz','log_data.tar.gz','opt_data.tar.gz.aa','opt_data.tar.gz.ab','opt_data.tar.gz.ac'].each |$f| {
      file{"/tmp/${f}":
        ensure => file,
        source => "puppet:///modules/vagrant_bolt_gitlab/${f}",
      }
    }
  }

  run_task('vagrant_bolt_gitlab::extract_supporting_files', $targets)
}
