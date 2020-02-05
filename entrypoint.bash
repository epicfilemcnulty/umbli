#!/bin/bash

say () {

    echo
    echo "----------------------------"
    echo "* ${1} "
    echo "----------------------------"
    echo 

}

if [[ "${1}" == "strict" ]]; then
    set -euo pipefail
    echo "*** Running in strict mode, every linting error causes immediate exit with an error code"
else
    echo "** Running in loose mode"
fi

CONFIG="${CONFIG:-.umbli.sh}"
if [[ -f "${CONFIG}" ]]; then
    source "${CONFIG}"
else
    echo "Config not found: ${CONFIG}"
    exit 1
fi

if [[ -v CREDS_SCAN ]]; then
    say "Running credentials scan"
    gitleaks
fi

if [[ -v SHELL_FILES ]]; then
    say "Linting shell files"
    shellcheck --color -a -s bash ${SHELL_FILES[@]}
fi

if [[ -v TERRAFORM_FILES ]]; then
    say "Linting terraform files"
    tfsec
fi

if [[ -v ANSIBLE_FILES ]]; then
    say "Linting ansible files"
    ansible-lint --force-color --parseable-severity ${ANSIBLE_FILES[@]}
fi

if [[ -v KUBE_FILES ]]; then
    say "Running kube-score"
    kube-score score ${KUBE_FILES[@]}
fi
