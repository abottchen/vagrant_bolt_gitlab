#!/bin/bash
cat /tmp/opt_data.tar.gz.a* >> /tmp/opt_data.tar.gz
tar -xvf /tmp/etc_data.tar.gz -C /
tar -xvf /tmp/log_data.tar.gz -C /
tar -xvf /tmp/opt_data.tar.gz -C /
rm /tmp/etc_data.tar.gz
rm /tmp/log_data.tar.gz
rm /tmp/opt_data.tar.gz
rm /tmp/opt_data.tar.gz.a*
