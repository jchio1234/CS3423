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
        if(extra_credit == "true") {

        }
        print "s/"l_char "simple_name" r_char "/" sName "/g" > item_num ".sed"
        print "s/"l_char "item_name" r_char "/" iName "/g" > item_num ".sed"
        print "s/"l_char "current_quantity" r_char "/" cQuan "/g" > item_num ".sed"
        print "s/"l_char "max_quantity" r_char "/" mQuan "/g" > item_num ".sed"
        print "s/"l_char "body" r_char "/" body "/g" > item_num ".sed"
        print "s:"l_char "date" r_char ":" g_date ":g" > item_num ".sed"
        exit
    }
}
END {
}
