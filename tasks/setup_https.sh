#!/bin/bash
export ETCDIR="/var/lib/docker/volumes/gitlab_etc/_data"
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj "/C=US/ST=Oregon/L=Portland/O=Puppet/CN=$(hostname -f)" -keyout "${ETCDIR}/ssl/$(hostname -f).key" -out "${ETCDIR}/ssl/$(hostname -f).crt"
echo "external_url 'https://$(hostname -f)'" > ${ETCDIR}/gitlab.rb
docker exec -it gitlab gitlab-ctl reconfigure
