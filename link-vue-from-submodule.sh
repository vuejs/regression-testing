#!/bin/bash
base_directory=$(cd "$(dirname "$0")/"; pwd)
working_directory="$(pwd)"

cd "${base_directory}/vue"
yarn link

cd "${working_directory}"
yarn link vue

for dir in ${base_directory}/vue/packages/*/; do
  cd "${dir}"
  yarn link

  package="$(basename $dir)"
  cd "${working_directory}"
  yarn link "${package}"
done
