#!/usr/bin/env fish

# checks a single domain to see if it resolves to an actual address
# for use with filtered DNS to determine domain category
# successful resolves are written to a file
# usage: fish filter_2_1_dns.sh domain outfile

set outfile $argv[2]

function check_fail
    echo (set_color red)"NO:  "(set_color normal)$argv[1]
end

function check_pass
    echo (set_color green)"YES: "(set_color normal)$argv[1]
    echo $argv[1] >>$outfile
end

function check
    set lookup $(nslookup $argv[1] | tail -n +5)
    if string match -qre "Address:.*[1-9].*" $lookup
        check_pass $argv[1]
    else if string match -qre canonical $lookup
        check_pass $argv[1]
    else
        check_fail $argv[1]
    end
end

check $argv[1]
