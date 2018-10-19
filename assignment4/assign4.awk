BEGIN {total=0}
{
    split(fName,d,"/");
    sfName=d[3];
}
END {
    printf("awk filename: %s\n", sfName);
    printf("awk simple name: %s\n", sName);
    printf("awk item name: %s\n", iName);
    printf("awk current quantity: %s\n", cQuan);
    printf("awk max quantity: %s\n", mQuan);
    printf("awk body: %s\n", body);
    print("\n");
}
