#!/usr/bin/env fish

# checks a single domain to see if it resolves
# successful resolves are written to a file
# usage: fish filter_1_1_dns.sh domain outfile

set outfile $argv[2]

function check_fail
    echo (set_color red)"NO:  "(set_color normal)$argv[1]
end

function check_pass
    echo (set_color green)"YES: "(set_color normal)$argv[1]
    echo $argv[1] >> $outfile
end

function check
    string match -qe "an't find" $(nslookup $argv[1]) &&
        check_fail $argv[1] ||
        check_pass $argv[1]
end

check $argv[1]
