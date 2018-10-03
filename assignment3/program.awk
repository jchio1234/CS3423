$1 ~ /[a-z]{3}[0-9]{3}/ {
    if ($1 in count)
        count[$1] += 1;
    else
        count[$1] = 1;

    if ($1 in host == 0)
        host[$1] = $3

    if ($1 in time == 0)
        time[$1] = $7;
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
