#!/bin/bash

#
# Instead of
#
#  selenium/node-firefox:2.53.1
#  selenium/standalone-firefox:2.53.1
#  selenium/node-firefox-debug:2.53.1
#
# Build with ESR version of Firefox
#
#  fc/selenium-node-firefox:2.53.1-esr
#  fc/selenium-standalone-firefox:2.53.1-esr
#  fc/selenium-standalone-firefox-debug:2.53.1-esr
#

set -eu
set -o pipefail

VERSION=2.53.1
ESR_VERSION=${VERSION}-esr

cd ./NodeFirefox
  ./generate.sh ${VERSION}
  docker build -t fc/selenium-node-firefox:${ESR_VERSION} .
cd ..
cd ./Standalone
  ./generate.sh StandaloneFirefox selenium-node-firefox Firefox ${ESR_VERSION}
cd ..
cd ./StandaloneFirefox 
  docker build -t fc/selenium-standalone-firefox:${ESR_VERSION} .
cd ..
cd ./StandaloneDebug 
  ./generate.sh StandaloneFirefoxDebug selenium-standalone-firefox Firefox ${ESR_VERSION}
cd ..
cd ./StandaloneFirefoxDebug
  docker build -t fc/selenium-standalone-firefox-debug:${ESR_VERSION} .
cd ..
