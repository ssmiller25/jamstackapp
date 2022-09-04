#!/bin/bash
#
# Automation from tutorial/2-static.md
#

# TODO: Decite civo binary in path, use that instead of docker container
CIVO='docker run -it --rm -v /home/gitpod/.civo.json:/.civo.json -v /home/gitpod/.kube/config:/root/.kube/config civo/cli:latest'
pushd ${GITPOD_REPO_ROOT}

if ${CIVO} k3s show jamstacksite > /dev/null; then
  echo "jamstacksite cluster exists, continuing"
else
  ${CIVO} k3s create jamstacksite -n 2 --wait
  ${CIVO} k3s config jamstacksite --save --merge
  kubectl config use-context jamstacksite
fi

