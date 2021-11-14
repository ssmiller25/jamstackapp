#!/bin/sh
#
# Setup initial civo kubectl with ALL cluster imported

if [ -n "${CIVO_API_KEY}" ]; then
    if ! civo apikey add default "$CIVO_API_KEY" > /dev/null 2>&1; then
        echo "CIVO API add failed.  Check your \$CIVO_API_KEY variable.  See README.md for details."
        exit 1
    fi
    mkdir "${HOME}"/.kube > /dev/null 2>&1
    kubectl config view --raw > "${HOME}"/.kube/config
    for cluster in $(civo k3s list -o custom -f "name"); do
        civo k3s config "${cluster}" --save --merge
    done
fi