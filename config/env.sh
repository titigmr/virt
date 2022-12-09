#!/bin/sh

cat << EOF > etc/profile.d/env.sh
%{ for key, value in jsondecode(ENVIRONMENT) ~}
export $key=$value
%{ endfor ~}
EOF