plan vagrant_bolt_gitlab::install (
  TargetSpec $targets) {

 run_plan('vagrant_bolt_gitlab::install_docker', $targets) 
 run_plan('vagrant_bolt_gitlab::install_supporting_files', $targets) 
 run_task('vagrant_bolt_gitlab::unprotect_branches', $targets)
}
