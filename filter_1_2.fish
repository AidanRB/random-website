#!/usr/bin/env fish

# checks a list of domains read from a file to see if they resolve
# usage: fish filter_1_2.sh infile outfile concurrent_checks

set total_lines (wc -l $argv[1] | awk '{print $1}')
set threads_num $argv[3]

for i in (seq (math $total_lines/$threads_num+1))
    echo (math "$i*$threads_num")"..."
    set range_start (math "($i-1)*$threads_num+1")
    set range_end (math "$i*$threads_num")
    parallel -i -j $argv[3] fish ./filter_1_1_dns.fish {} $argv[2] -- (sed -n "$range_start,$range_end""p" $argv[1])
end
