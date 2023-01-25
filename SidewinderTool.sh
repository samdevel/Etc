#!/bin/tcsh

# Sidewinder Diagnostic Tool v0.9
# For Internal Use
# Written by sm@devel
# Feel free to involve in writing and developing!


#Routine Starts here


backupV7 ()

{

if [ ! -f comvar ]
then
   echo "you are in diagnostic mode"
   echo "need to execute the script and choose 3 to proceed the diagnostics"
   echo "Exiting ..."
   sleep 1
exit
fi

#var
file=Data_SW7_`hostname`_`date +%F`
echo File Name: $file


echo " #----------------------------#" >> $file
echo "            Summary  " >> $file
echo "            *******" >> $file
echo " " >> $file
echo "          Version: 7" >> $file
echo "       Date: `date +%F`" >> $file
echo "      Hostmame: `hostname`" >> $file
echo " #----------------------------#" >> $file
echo " " >> $file

# Routine
CountLine=`cat comvar | wc -l`
echo " "
echo "number of commands: $CountLine"
echo "Start collecting ..."
echo " "


num=1
while [ $num -le $CountLine ]
do 
   cmd=`cat comvar | head -$num | tail -1`
   echo "# $cmd #" >> $file
   #echo  $cmd 
   $cmd >> $file
   echo "---*************************************---" >> $file
   echo -n "#"
   num=$(( $num+1 )) 
   sleep 1
done
  

echo " "
echo "done!"
echo "File saved in: `pwd` directory"

}

backupV8 ()

{
echo ""

if [ ! -f comvar8 ]
then
   echo "you are in diagnostic mode"
   echo "need to execute the script and choose 3 to proceed the diagnostics"
   echo "Exiting ..."
   sleep 1
exit
fi

#var
file=Data_SW8_`hostname`_`date +%F`
echo File Name: $file


echo " #----------------------------#" >> $file
echo "            Summary  " >> $file
echo "            *******" >> $file
echo " " >> $file
echo "          Version: 8" >> $file
echo "       Date: `date +%F`" >> $file
echo "      Hostmame: `hostname`" >> $file
echo " #----------------------------#" >> $file
echo " " >> $file

# Routine
CountLine=`cat comvar8 | wc -l`
echo " "
echo "number of commands: $CountLine"
echo "Start collecting ..."
echo " "


num=1
while [ $num -le $CountLine ]
do 
   cmd=`cat comvar8 | head -$num | tail -1`
   echo "# $cmd #" >> $file
   #echo  $cmd 
   $cmd >> $file
   echo "---*************************************---" >> $file
   echo -n "#"
   num=$(( $num+1 )) 
   sleep 1
done
  

echo " "
echo "done!"
echo "File saved in: `pwd` directory"

}


diagnostic ()
{
echo ""
echo ""
echo "Still thinking what codes to be here, help me :)"
echo ""
echo ""

#Reboot error dump logs
sleep 2
clear

}


ReleaseNotes ()
{
echo " Release Notes"
echo " "
echo " 1. Manual entry of commands removed"
echo " 2. Array declaration removed"
echo " 3. Add Selection Menu"
echo " 4. Support Sidewinder Version 7 and Version 8"
echo " 5. Version 8 module to be enabled "
echo " 6. Diagnostic Tool module to be added for Future Use"
echo " 7. Shell declaration changed to tc sheell"
echo ""
sleep 5
clear
}


show_menu ()
{
echo ""
echo "***************************"
echo "*  Sidewinder Tool V.0.9  *"
echo "*     For Internal Use    *"
echo "*  Developed by sm@Devel  *"
echo "***************************"
echo ""
echo "------ Menu -----"
echo -n "Selection press [1, 2 or 3] to collect data"
echo ""
echo "1. Sidewinder 7"
echo "2. Sidewinder 8"
echo "3. Diagnostic Tool"
echo "r. Release Notes"
echo "x. Exit"
echo "------******-----"
echo -n "Selection: "
}


########## Main ###########
clear
while true
do
     show_menu
     read select
     case $select in
        1)
        #echo "For Sidewinder 7"
        backupV7
        ;;
        2)
        # echo "For Sidewinder 8"
        backupV8
        ;;
        3)
        diagnostic
        ;;
        r)
        ReleaseNotes
        ;;
        x)
        echo "Exit ..."
        echo ""
        echo ""
        exit 0
        ;;
        *)
        echo ""
        echo "--- Wrong choice, Kindly select either 1, 2 or 3 ! ---"
        echo ""
        ;;
     esac
done

#=======================EndOfScript==========================
