plan vagrant_bolt_gitlab::install_docker(
  TargetSpec $targets,
) {
  $targets.apply_prep

  apply($targets) {
    include docker

    docker::run { 'gitlab':
      image   => 'gitlab/gitlab-ce:latest',
      ports   => ['443:443'],
      volumes => [
                         'gitlab_etc:/etc/gitlab', 
                         'gitlab_opt:/var/opt/gitlab', 
                         'gitlab_log:/var/log/gitlab'
                        ],
      pull_on_start    => true,
      detach           => true,
    }
  }

  $result = run_task('vagrant_bolt_gitlab::waitfordocker', $targets)

  return $result
}
