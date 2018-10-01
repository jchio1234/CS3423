$1 ~ /[a-z]{3}[0-9]{3}/ {
#Determine the number of times that a user has logged in
    if ($1 in users)
    {
        users[$1] += 1;
        users[$1][host] = $3;
        users[$1][host][time] = $2;
    }
    else
    {
        users[$1] = 1;
        users[$1][host] = $3;
        users[$1][host][time] = $2;
    }
}
END {
    for (key in users)
    {
        for (host in users[host])
        {
            for (time in users[host][time])
            {
                printf("User: %s\n", key);
                printf("        Last host: %s\n", users[key][host]);
                printf("        Total Time: %s\n", users[key][host][time]);
                printf("        Total Sessions: %s\n", users[key]);
            }
        }
    }
}
