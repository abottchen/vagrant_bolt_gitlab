yum install -y https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
yum install -y puppet
/opt/puppetlabs/bin/puppet module install puppetlabs-docker
/opt/puppetlabs/bin/puppet apply -e "include docker"
docker run --name=cd4pe-gitlab -d -p 443:443 -v gitlab_etc:/etc/gitlab -v gitlab_opt:/var/opt/gitlab -v gitlab_log:/var/log/gitlab --env GITLAB_OMNIBUS_CONFIG="gitlab_rails['initial_root_password'] = 'puppetlabs';" gitlab/gitlab-ce:latest
while docker ps |grep "health: starting" > /dev/null; do echo "Waiting on container startup..."; sleep 10; done
curl -sLo /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x /usr/local/bin/jq
export ETCDIR=$(docker volume inspect gitlab_etc |jq -r ".[0].Mountpoint")
export OPTDIR=$(docker volume inspect gitlab_opt |jq -r ".[0].Mountpoint")
export LOGDIR=$(docker volume inspect gitlab_log |jq -r ".[0].Mountpoint")
tar -xvf etc_data.tar.gz -C /
tar -xvf log_data.tar.gz -C /
tar -xvf opt_data.tar.gz -C /
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj "/C=US/ST=Oregon/L=Portland/O=Puppet/CN=$(hostname -f)" -keyout "${ETCDIR}/ssl/$(hostname -f).key" -out "${ETCDIR}/ssl/$(hostname -f).crt"
echo "external_url 'https://$(hostname -f)'" >> ${ETCDIR}/gitlab.rb
docker stop cd4pe-gitlab
docker start cd4pe-gitlab
