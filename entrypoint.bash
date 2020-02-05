#!/bin/bash

UMBLI_CONFIG="${UMBLI_CONFIG:-/app/.umbli.sh}"
if [[ -f "${UMBLI_CONFIG}" ]]; then
    source "${UMBLI_CONFIG}"
fi

say () {

    echo
    echo "----------------------------"
    echo "* ${1} "
    echo "----------------------------"
    echo 

}

say "Running credentials scan"
gitleaks

if [[ -v SHELL_FILES ]]; then
    say "Linting shell files"
    shellcheck -a -s bash ${SHELL_FILES[@]}
fi

say "Linting terraform files"
tfsec

if [[ -v ANSIBLE_FILES ]]; then
    say "Linting ansible files"
    ansible-lint --force-color --parseable-severity ${ANSIBLE_FILES[@]}
fi

if [[ -v KUBE_FILES ]]; then
    say "Running kube-score"
    kube-score score ${KUBE_FILES[@]}
fi
