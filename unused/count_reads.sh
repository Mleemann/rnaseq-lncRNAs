#!/usr/bin/env bash

for target in *.gz; do
    echo "$target"
    cat $target |
        awk 'NR%4==2{c++; l+=length($0)}
        END{
            print "    Number of reads: "c;
            print "    Number of bases in reads: "l
         }'
done >> count_reads.txt
