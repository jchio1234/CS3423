$1 ~ /[a-z]{3}[0-9]{3}/ {
    if ($1 in count)
        count[$1] += 1;
    else
        count[$1] = 1;

    if ($1 in host == 0)
        host[$1] = $3

    if ($1 in time == 0)
    {
        gsub(/[()]/, "", $NF);
        time[$1] = $NF;
    }
    else
    {
        #If this is true, the last field is a time
        if ($NF !~ /in/)
        {
            prev = time[$1];
            split(prev, a, ":");
            time[$1] = a[2];
        }
        #This field is an "in" which means to calculate from date time
        else
        {
            time[$1] = "fix this";
        }
    }
}
END {
    for (key in count)
    {
        printf("User: %s\n", key);
        printf("        Last host: %s\n", host[key]);
        printf("        Total Time: %s\n", time[key]);
        printf("        Total Sessions: %s\n", count[key]);
    }
}
