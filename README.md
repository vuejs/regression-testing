# Vue.js Regression Test

Regression test for popular libraries in Vue.js ecosystem.

Run periodically against Vue.js `dev` branch.
Can also be manually triggered by pushing to Vue.js `regression-test` branch.

## Build & Run

Since we use CircleCI workflows to speed up tests for multiple libraries, it is not impossible to run them locally.

## Included Libraries

- [element-ui](https://github.com/ElemeFE/element)
- [nuxt](https://github.com/nuxt/nuxt.js)
- [vuetify](https://github.com/vuetifyjs/vuetify/)

## How to Add/Update Third Party Libraries

### Requirements for Including Libraries

- Significant user base
- No failing tests for currently Vue.js stable release
- No random failing tests

### To Add a New Library

Adding a new library requires the following steps:

- Add git submodule (point to the latest stable release tag)
- Config test job for CircleCI
  - Take the `vuetify` job as a reference
  - If tests are run by `jest`, add `--maxWorkers 2` to `jest` argument list (otherwise it will cause memory issues on CircleCI)
- Add test job to `test_all` workflow

### To Update an Existing Library

Third-party libraies should be updated manually.
The basic idea is to update libraries to their latest **stable** releases.
Release tags are listed on their corresponding GitHub Releases pages.

```
git submodule update --remote <directory-name>
cd <directory-name>
git checkout <latest-stabe-version>
cd ..
git add <directory-name>
git commit -m 'chore: update library version'
git push
```