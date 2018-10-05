$1 ~ /[a-z]{3}[0-9]{3}/ {
    if ($1 in count)
        count[$1] += 1;
    else
        count[$1] = 1;

    if ($1 in host == 0)
        host[$1] = $3;

    if ($1 in test == 0)
        test[$1] = "test";

    if ($1 in time == 0)
    {
        if($NF == "in")
        {
            #User is still logged in
            split(date,d);
            d_input = d[4];
            split(d_input,t,":");
            d_seconds = 3600*t[1] + 60*t[2];
            test[$1] = cdate;
            i_time = $7;
            split(i_time,iarr,":");
            i_seconds = 3600*iarr[1] + 60*iarr[2];
            logged_in_seconds = d_seconds - i_seconds;
            new_hour = int(logged_in_seconds/3600);
            logged_in_seconds = logged_in_seconds - (new_hour*3600);
            new_minutes = int(logged_in_seconds/60);
            time[$1] = new_hour":"new_minutes;
        }
        else
        {
            #User has only logged in once
            gsub(/[()]/, "", $NF);
            time[$1] = $NF;
        }
    }
    else
    {
        #User has logged in more than once
        prev_time = time[$1];
        split(prev_time,p,":");
        prev_seconds = 3600*p[1] + 60*p[2];
        gsub(/[()]/,"", $NF);
        new_time = $NF;
        split(new_time,n,":");
        new_seconds = 3600*n[1] + 60*n[2];
        new_total = prev_seconds + new_seconds;
        new_h = int(new_total/3600);
        new_total = new_total - (new_h * 3600);
        new_m = int(new_total/60);
        time[$1] = new_h":"new_m;
    }
}
END {
    for (key in count)
    {
        printf("User: %s\n", key);
        printf("        Last host: %s\n", host[key]);
        printf("        Total Time: %s\n", time[key]);
        printf("        Total Sessions: %s\n", count[key]);
        printf("        Test: %s\n", test[key]);
    }
}
