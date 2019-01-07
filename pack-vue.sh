#!/bin/bash
base_directory=$(cd "$(dirname "$0")/"; pwd)

cd "${base_directory}/vue"
yarn pack

for dir in ${base_directory}/vue/packages/*/; do
  cd "${dir}"
  yarn pack
done
