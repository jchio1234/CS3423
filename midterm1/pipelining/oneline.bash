ps -af | grep -F -w "vi" | gawk '$8 ~ /^vi/ {print $1, $2}'
