#!/bin/sh -l

set -eu

apt-get update && apt-get install -y \
  ant \
  git \
  openjdk-8-jdk

git clone $1
git submodule update --init

cp -r src/** appinventor/components/src

cd appinventor/
ant clean
ant MakeAuthKey
ant extensions -Dproguard=0

cd ../..

cd appinventor/components/build/extensions
file=$(dir)
echo ::set-output name=file::$file

cd ../../../../..
