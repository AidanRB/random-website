#!/usr/bin/env fish

while read line
    string match -q -- "*Can't find*" $(nslookup $line) || echo $line >> $argv[2]
end < $argv[1]