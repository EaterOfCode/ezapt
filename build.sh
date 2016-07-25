#!/usr/bin/env bash
DIR="$(realpath "$(dirname $0)")";

echo "Building ${1}";
mkdir .result;
docker build -t eater/ezapt .;
docker run -v $(realpath ./.result):/result -v $(realpath .):/ezapt eater/ezapt bash /ezapt/run.sh "$1";
mv -f ./.result/*.deb "./dists/daily/main/binary/${1}.deb";
cd ./dists/daily/main/binary;
dpkg-scanpackages binary /dev/null | gzip -9c > binary/Packages.gz;
cd "$DIR";
rm -rf .result;
./build-release-file.sh;
