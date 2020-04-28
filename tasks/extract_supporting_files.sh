#!/bin/bash
tar -xvf /tmp/etc.tar.gz -C /
rm /tmp/etc.tar.gz
docker exec -it gitlab sed -ie "s/ask_to_continue//g" /opt/gitlab/embedded/service/gitlab-rails/lib/tasks/gitlab/backup.rake
docker exec -it gitlab sed -ie "s/ask_to_continue//g" /opt/gitlab/embedded/service/gitlab-rails/lib/tasks/gitlab/shell.rake
docker exec -it gitlab gitlab-backup restore > /tmp/gitlab_restore.log
