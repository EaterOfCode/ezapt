#!/usr/bin/env bash

echo "Building ${1}";
mkdir .result;
docker build -t eater/ezapt .;
docker run -v $(realpath ./.result):/result -v $(realpath .):/ezapt eater/ezapt bash /ezapt/run.sh "$1";
mv -f ./.result/*.deb "./repo/binary/${1}.deb";
cd ./dists/main;
dpkg-scanpackages binary /dev/null | gzip -9c > binary/Packages.gz;
rm -rf .result;
