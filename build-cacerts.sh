#!/usr/bin/env bash

# check here how long the file has changed https://hg.mozilla.org/projects/nss/log/tip/lib/ckfw/builtins/certdata.txt

wget https://hg.mozilla.org/projects/nss/raw-file/default/lib/ckfw/builtins/certdata.txt -O certdata.txt

# https://github.com/curl/curl/commits/master/lib/mk-ca-bundle.pl to check when it has changed last
wget https://raw.githubusercontent.com/curl/curl/master/lib/mk-ca-bundle.pl -O mk-ca-bundle.pl

wget https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar -O keyutil-0.4.0.jar

sha256sum keyutil-0.4.0.jar | grep -q 9d828d97053868907ce6229d132132f0f26772393405dadd037b6f85a5c5b219 || {
    echo "keyutil changed. please review. decide for yourself, update the hash, be the change you seek, yadda yadda."
    exit 1
}

# -n don't download certdata.txt
# -f force gen, even if certdata doesn't seem old
perl mk-ca-bundle.pl -n -f

java -jar keyutil-0.4.0.jar --import --new-keystore trustStore.jks --password changeit --force-new-overwrite --import-pem-file ca-bundle.crt

mkdir -p target

mv trustStore.jks target/cacerts

# from
# https://github.com/AdoptOpenJDK/openjdk-build/tree/master/security