BEGIN { FS=","; count=0; }
#Count number of rows that end in Spring 2018
{
    if ($1 ~ /^[Cc][Ss][34]/)
    {
        if($NF == "Spring 2018")
        {
            count++;
            printf("%s: %s\n", $2, $3);
        }
    }
}
END {
    printf("Total: %s\n", count);
}
