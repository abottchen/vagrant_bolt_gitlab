#!/bin/bash

TOKEN="FvmcbSWwpS9LxZYs1iBt"
curl --request DELETE --header "PRIVATE-TOKEN: ${TOKEN}" 'http://$(hostname -f)/api/v4/projects/1/protected_branches/production'
curl --request DELETE --header "PRIVATE-TOKEN: ${TOKEN}" 'http://$(hostname -f)/api/v4/projects/2/protected_branches/master'
