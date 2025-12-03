#!/usr/bin/env bash

# --- Generate resource packs ---
jar_name="slimepack-standalone-2.22-SNAPSHOT-all.jar"
versions=("1.21.10" "1.21.9" "1.21.8" "1.21.7" "1.21.6" "1.21.5" "1.21.4")

for version in "${versions[@]}"; do
    java -jar $jar_name $version
done

# --- Upload files ---
sftp "website@ageofelysian.com" <<EOF
cd website/static/resource-pack
$(for version in "${versions[@]}"; do
    echo "put generated/resource-pack-$version.zip"
done)
ls
bye
EOF

echo "Upload finished."
