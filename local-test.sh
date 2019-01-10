#!/bin/bash
cd vue
git checkout -- .
cd ..

git submodule sync
git submodule update --init

cd vue
if [ "$1" ]
then
  echo "Checking out $1"

  git fetch
  git checkout $1
else
  echo "No commit hash or branch specified, testing with commit $(git rev-parse --short HEAD)"
fi
yarn install --pure-lockfile
yarn build
../pack-vue.sh

installDeps() {
  yarn install --frozen-lockfile --non-interactive
}

installLocalVue() {
  yarn add -W ../vue/vue-v*.tgz \
    ../vue/packages/vue-server-renderer/vue-server-renderer-v*.tgz \
    ../vue/packages/vue-template-compiler/vue-template-compiler-v*.tgz
}

cleanup() {
  git checkout -- .
  rm -rf node_modules
}

cd ../element
echo -e "\n\nTesting element…\n\n"
read version _ <<< $(node --version)
if [[ $version != *"v8."* ]]; then
  echo "Element requires Node.js v8, please switch your default Node.js version"
  exit
fi
installDeps
installLocalVue
# must install twice
installLocalVue
yarn test
cleanup

cd ../nuxt.js
echo -e "\n\nTesting nuxt.js…\n\n"
installDeps
installLocalVue
rm ../test-nuxt.js.log
NODE_ENV=test yarn test:fixtures -w=4
NODE_ENV=test yarn test:unit -w=4
NODE_ENV=test yarn test:e2e
cleanup

cd ../vuetify
echo -e "\n\nTesting vuetify…\n\n"
installDeps
installLocalVue
npx lerna run test:coverage -- -i
cleanup

echo -e "\n\nTest done"
