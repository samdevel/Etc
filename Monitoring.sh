#!/bin/bash

# This tool is to monitor a task (cmd)
# Developed by sm@Devel
# Feel free to contribute/develop
# Applicable for Unix/Linux platform
# Shell declaration can be changed if not working 

echo ""
echo "****************************"
echo "*   Monitoring Tool v.0.6  *"
echo "*      For Internal Use    *"
echo "*   Developed by sm@Devel  *"
echo "****************************"
echo ""

# Var
echo "--------------Input----------------"
echo "[60sec=1Min; 3600sec=1H; 86400=1day]"
echo -n "Iteration [number of count]     : " 
read Iteration

echo -n "Interval monitoring [in second] : "
read Interval

echo -n "Enter a command: "
read Command

echo -n "File name as   : "
read file

total=$(($Iteration * $Interval))
echo "Consuming time in total is: $total [secs]"
#echo "[3600sec=1H; 86400=1day]"
echo "-----------------------------------" 
echo

# Routine

num=1
while [ $num -le $Iteration ]
do
   $Command >> $file 
   echo "**********" >> $file
   num=$(( $num+1 ))
   echo -n "#"
   sleep $Interval
done

echo ""
echo " Monitoring Complete!"
echo " your file [ $file ] will be saved here `pwd`"
echo ""
echo "Report the bug(s) to sm@Devel"

# End of Script
