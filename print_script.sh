#!/bin/bash

# My printer script file.

FAB=("fab5517bw1 fab5517bw2 fab6019bw1 fab6001bw1 fab5517clr1")
EB=("eb325bw1 eb325bw2 eb423bw1 eb325clr1 eb423clr1")
CAT=("fab8201bw1")

printpage="/cat/doc/zombies/PrinterTest.jpg"

#Takes in an argurment passed in form the interface function and prints to the
#designated printers. 
function sendjobs { 
    for i in ${var[@]};
    do
       lpr -P $i $printpage;
       echo "printed to $i"

    done

}

#Takes the input read in from the user and passes it to the prper if statement. 
#depending ong the values passed different printers will have jobs sent to them. 
function interface {
    for t in $PRINTER
    do
        if [ "$t" == "FAB" ]; then
            var=$FAB 
            sendjobs $var
          
        elif [ "$t" == "EB" ]; then
            var=$EB
            sendjobs $var
         
        elif [ "$t" == "BOTH" ]; then
            var=$FAB
            sendjobs $var
            var=$EB
            sendjobs $var
        elif [ "$t" == "CAT" ]; then
            var=$CAT
            sendjobs $var
            
        elif [ "$t" == "ALL" ]; then
            var=$FAB
            sendjobs $var
            var=$EB
            sendjobs $var
            var=$CAT
            sendjobs $var
         elif [ "$t" == "SINGLE" ]; then
             printf "\n /////////////////////////////////////////////////////////// \n"
             printf "\n Which Printer do you want to print to? \n \n [fab5517bw1] [fab5517bw2] [fab6019bw1] [fab6001bw1] [fab5517clr1] \n" 
             printf " [eb325bw1] [eb325bw2] [eb325clr1] [eb423bw1] [eb423clr1] \n" 
             printf " [fab8201bw1] \n \n"
             printf " /////////////////////////////////////////////////////////// \n"

             read single
             P=${single,,}

             lpr -P $P $printpage;
             echo "printed to $P"


        else
           
            sendjobs $t
        fi
    done
}

#If no argumets are provided upon script call. A interface menu will pop up. 
if [ $# == 0 ]; then 
#which printer do you want to use?
    printf "\n /////////////////////////////////////////////////////////// \n"
    printf "\nWhich printer would you like to print to? your options are: \n"
    printf "[fab] [eb] [both] [cat] [all] or [single]\n\n"
    printf " /////////////////////////////////////////////////////////// \n"

    read printer
#converting input into uppercase.   
    PRINTER=${printer^^}
     

#sending arugment to "send jobs" function. The interface function will then interpret the input and
#print send the requested printers onto the "sendjobs junction".
    interface "$PRINTER"
else
    echo "invallid Call $printer "
fi

