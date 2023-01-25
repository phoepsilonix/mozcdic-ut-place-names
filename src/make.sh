#!/bin/bash

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

ruby fix_ken_all.rb
ruby generate_place_names_for_mozc.rb

tar cjf mozcdic-ut-place-names.txt.tar.bz2 mozcdic-ut-place-names.txt
mv mozcdic-ut-place-names.txt* ../
