#!/bin/sh

echo $@
DIC=place-names
SYSTEMDIC=mozcdic-ut-$DIC
USERDIC=user_dic-ut-$DIC
BASE=$PWD
python generate_place_names.py 
tar cf ../release/${SYSTEMDIC}.tar ${SYSTEMDIC}.txt ../LICENSE
bzip2 -9 ../release/${SYSTEMDIC}.tar

curl -LO https://github.com/phoepsilonix/dict-to-mozc/releases/download/v0.3.9/dict-to-mozc-x86_64-unknown-linux-gnu.tar.gz
tar xf dict-to-mozc-x86_64-unknown-linux-gnu.tar.gz --strip-component=1

curl -LO https://github.com/google/mozc/raw/refs/heads/master/src/data/dictionary_oss/id.def
# ut dic
PATH=$HOME/.cargo/bin:$PATH
./dict-to-mozc -u -U -S -p -i ./id.def -f ./$SYSTEMDIC.txt > ./$USERDIC
ls -la $USERDIC*
split --numeric-suffixes=1 -l 1000000 --additional-suffix=.txt $USERDIC $USERDIC-

mkdir -p ../release
[[ -e ../release/${USERDIC}.tar.xz ]] && rm ../release/${USERDIC}.tar.xz

tar cf ../release/${USERDIC}.tar ${USERDIC}-*.txt ../LICENSE.user_dic
xz -9 -e ../release/${USERDIC}.tar

rm $USERDIC $USERDIC-*.txt ./$SYSTEMDIC.txt
