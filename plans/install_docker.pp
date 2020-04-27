plan vagrant_bolt_gitlab::install_docker(
  TargetSpec $targets,
) {
  $targets.apply_prep

  apply($targets) {
    include docker

    docker::run { 'gitlab':
      image   => 'gitlab/gitlab-ce:12.10.1-ce.0',
      ports   => ['80:80','443:443','8022:22'],
      volumes => [
                         'gitlab_etc:/etc/gitlab', 
                         'gitlab_opt:/var/opt/gitlab', 
                         'gitlab_log:/var/log/gitlab'
                        ],
      pull_on_start    => true,
    }
  }

  run_task('vagrant_bolt_gitlab::start_gitlab', $targets)
  $result = run_task('vagrant_bolt_gitlab::waitfordocker', $targets)

  return $result
}
