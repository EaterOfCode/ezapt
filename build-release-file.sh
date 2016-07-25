#!/usr/bin/env bash
cat > ./dists/daily/Release <<EOF
Origin: EaterOfCode
Label: EaterOfCode
Suite: Main
Date: $(date +"%a, %d %b %Y %X %Z")
SHA256:
EOF

cd ./dists/daily;
find * -type f -print0 | while read -d '' -r file; do
if [ "$file" != "Release" ] && [ "$(basename "$file")" != ".gitkeep" ]; then
        echo " $(sha256sum "$file" | awk '{print $1}') $(stat --printf="%s" "$file") $file" >> Release;
    fi
done
gpg2 -a -b -s --output ./dists/daily/Release.gpg ./dists/daily/Release;
gpg2 --clearsign --output ./dists/daily/InRelease ./dists/daily/Release;
