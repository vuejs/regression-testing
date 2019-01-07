#!/bin/bash
base_directory=$(cd "$(dirname "$0")/"; pwd)
working_directory="$(pwd)"
vue_version="2.5.21"

cd "${working_directory}"
yarn add -W ../vue/vue-v${vue_version}.tgz

for dir in ${base_directory}/vue/packages/*/; do
  package="$(basename $dir)"

  if [[ $package != weex* ]]; then
    cd "${working_directory}"
    yarn add -W "${dir}/${package}-v${vue_version}.tgz"
  fi
done
