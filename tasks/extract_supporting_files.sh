#!/bin/bash
echo "Extracting configuration files"
tar -xvf /tmp/etc.tar.gz -C /
echo "Removing first prompt from restore script"
docker exec -i gitlab sed -ie "s/ask_to_continue//g" /opt/gitlab/embedded/service/gitlab-rails/lib/tasks/gitlab/backup.rake
echo "Removing second prompt from restore script"
docker exec -i gitlab sed -ie "s/ask_to_continue//g" /opt/gitlab/embedded/service/gitlab-rails/lib/tasks/gitlab/shell.rake
echo "Running gitlab restore"
docker exec -i gitlab gitlab-backup restore > /tmp/gitlab_restore.log 2>&1
echo "Cleaning up configuration data"
rm /tmp/etc.tar.gz
