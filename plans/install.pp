plan vagrant_bolt_gitlab::install (
  TargetSpec $targets) {

 run_plan('vagrant_bolt_gitlab::install_docker', $targets) 
 run_plan('vagrant_bolt_gitlab::install_jq', $targets) 
 run_task('vagrant_bolt_gitlab::stop_gitlab', $targets)
 run_plan('vagrant_bolt_gitlab::install_supporting_files', $targets) 
 run_task('vagrant_bolt_gitlab::setup_https', $targets) 
 run_task('vagrant_bolt_gitlab::start_gitlab', $targets)
 run_task('vagrant_bolt_gitlab::waitfordocker', $targets)
}
