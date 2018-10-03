$1 ~ /[a-z]{3}[0-9]{3}/ {
    if ($1 in count)
        count[$1] += 1;
    else
        count[$1] = 1;

    if ($1 in host == 0)
        host[$1] = $3

    if ($1 in time == 0)
    {
        gsub(/[()]/, "", $10);
        time[$1] = $10;
    }
    else
    {
        #Get previous total
        total = time[$1];
        #Split previous total into hours and minutes
        split(total, totalSplit, ":", seps);
        #Convert previous total into seconds
        totalSeconds = (totalSplit[0] + 0) * 3600 + (totalSplit[1] + 0) * 60;
        #Get current total  value
        currentTotal = $10;
        #Split current total into hours and minutes
        split(currentTotal, currentSplit, ":", curSeps);
        #Convert current total into seconds
        currentSeconds = (currentSplit[0] + 0) * 3600 + (currentSplit[1] + 0) * 60;
        #Add up previous and current seconds
        newSeconds = totalSeconds + currentSeconds;
        #Convert back to hours and minutes and assign to previous value
        #newHour = totalSeconds/3600;
        #totalSeconds = totalSeconds - (newHour * 3600);
        #newMinutes = totalSeconds/60;
        time[$1] = newSeconds;
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
