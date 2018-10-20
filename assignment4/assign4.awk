BEGIN {total=0}
{
    #Get the filename
    split(fName,d,"/");
    sfName=d[3];

    #Check the inventory percentage
    current_percentage=100.0*cQuan/mQuan;
    
    #Generate a sed script if percentage is less than 10
    if(current_percentage < 10) {
        split(sfName,f,".");
        item_num=f[1];
        print "s/"l_char "simple_name" r_char "/" sName "/g" > item_num ".sed"
        print "s/"l_char "item_name" r_char "/" iName "/g" > item_num ".sed"
        print "s/"l_char "current_quantity" r_char "/" cQuan "/g" > item_num ".sed"
        print "s/"l_char "max_quantity" r_char "/" mQuan "/g" > item_num ".sed"
        print "s/"l_char "body" r_char "/" body "/g" > item_num ".sed"
        print "s:"l_char "date" r_char ":" g_date ":g" > item_num ".sed"
        print "sed -i.out -E -f " item_num ".sed " template
        exit
    }
}
END {
    printf("awk template: %s\n", template);
    printf("awk item number: %s\n", item_num);
    printf("awk left char: %s\n", l_char);
    printf("awk right char: %s\n", r_char);
    printf("awk given date: %s\n", g_date);
    printf("awk filename: %s\n", sfName);
    printf("awk simple name: %s\n", sName);
    printf("awk item name: %s\n", iName);
    printf("awk current quantity: %s\n", cQuan);
    printf("awk max quantity: %s\n", mQuan);
    printf("awk current percentage: %d\n", current_percentage);
    printf("awk body: %s\n", body);
    print("\n");
}
