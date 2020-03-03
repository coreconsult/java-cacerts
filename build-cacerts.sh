#!/usr/bin/env bash

# check here how long the file has changed https://hg.mozilla.org/projects/nss/log/tip/lib/ckfw/builtins/certdata.txt

wget https://hg.mozilla.org/projects/nss/raw-file/default/lib/ckfw/builtins/certdata.txt

wget https://raw.githubusercontent.com/curl/curl/master/lib/mk-ca-bundle.pl

wget https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar

perl mk-ca-bundle.pl -n > ca-bundle.crt

java -jar keyutil-0.4.0.jar --import --new-keystore trustStore.jks --password changeit --force-new-overwrite --import-pem-file ca-bundle.crt



# from
# https://github.com/AdoptOpenJDK/openjdk-build/tree/master/security