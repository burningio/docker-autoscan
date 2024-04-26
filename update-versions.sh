#!/bin/bash
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/cloudbox/autoscan/commits/master" | jq -re '.sha') || exit 1
[[ -z ${version} ]] && exit 0
[[ ${version} == null ]] && exit 0
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    '.version = $version' <<< "${json}" | tee VERSION.json
