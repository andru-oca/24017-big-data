#!/bin/sh

directory="populate_data"
file_name="$1"

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
            }' "$file" | sed '$s/.$/; \n/' > ../"$directory/$name_part".sql
        fi
    done

}



remove_temp_files(){
    if [ -d ../"$directory" ]; then
        rm -rfv ../"$directory"
        echo "Directorio $directory ha sido borrado."
    else
        echo "Directorio inexistente"
    fi
}

if [ -d ../"$directory" ]; then
    rm -rfv ../"$directory"
    echo "Directorio $directory ha sido borrado."
else
    echo "Directorio inexistente"
fi

mkdir -p ../"$directory"

get_name_files
cat ../"$directory"/{nivel,genero,instructor,alumno,modelado}.sql > ../"$directory"/"$file_name".sql 
sed -i 's/""/NULL/g'  ../"$directory"/"$file_name".sql
sed -i "1s/^/USE colegio; \n \n /" ../"$directory"/"$file_name".sql
head -n 10 ../"$directory"/"$file_name".sql


mv -v ../"$directory"/"$file_name".sql ../big_data_sql_challenge
remove_temp_files

