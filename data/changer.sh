#!/bin/sh

get_name_files(){
    output_file="$1"
    for file in * ; do
        if [[ "$file" == *.csv ]]; then

            name_part="${file%%_*}"
            awk -v table="$name_part" 'BEGIN{FS=","; OFS=","} {
                if (NR==1) {
                    print "INSERT INTO " table "(" $0 ") \n\tVALUES"
                } else {
                    gsub(/"/, "", $0)
                    for (i=1; i<=NF; i++) {
                        $i = ($i !~ /^[0-9]+(\.[0-9]+)?$/) ? "\"" $i "\"" : $i
                    }
                    printf "\t(%s),\n", $0
                }
            }' "$file" | sed '$s/.$/; \n/' >> "$output_file"
        fi
    done

}


