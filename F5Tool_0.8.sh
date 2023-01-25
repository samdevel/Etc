#!/bin/bash

#Tool for F5-LTM/GTM version V.0.8 (initial release)
#This tool to be  used to collect the data
#before and after migration [verification] or troubleshooting
#For internal use ONLY
#Calls and Uses built-in conf file 
#Feel free in writing and developing

echo ""
echo "****************************************"
echo "*  F5 - LTM/GTM Diagnostic Tool v.0.8  *"
echo "*           For Internal Use           *"
echo "*         Developed by sm@Devel        *"
echo "****************************************"


# Var to call
cat /config/qkview/qkview_def.conf | tail -33 | sed 's/:/ /' | sed 's/:/ /' | sed 's/:/ /'>cmdbigip
cat /config/qkview/host_cmds.conf | head -96 | sed 's/:/ /' | sed 's/:/ /' | sed 's/:/ /' | sed 's/:/ /' >cmdhost


echo ""
echo "Ensure, your working directory shall be in /var/tmp"

dir1="/var/tmp"
dir2=`pwd`

if [ $dir1 != $dir2 ];then
    echo "Please change your directory!"
    echo "Sorry, I am quit ..."
    echo ""
    exit
fi   


echo -n "Save the data as: "
read file
mkdir $file
echo "the file will be saved in :/var/tmp/$file/$file "
echo ""
echo "Being started ..."

echo ""
# To save config.ucs
b config save /config.ucs 
b config save /var/tmp/$file/config.ucs
echo "config.ucs being saved"
echo ""

Line=`cat cmdbigip cmdhost | wc -l`
#echo "commands: $Line"
#echo "in progress ..."

count=1
while [ $count -le $Line ]
do
      var=`cat cmdbigip cmdhost | head -$count | tail -1`
      echo "########## $var ##########" >> $file/$file 
      $var >> $file/$file
      echo "" >> $file/$file
      echo -n "#"
      #echo -n "$count"
      count=$(($count+1))
#sleep 1 
done

rm -f cmdhost cmdbigip
echo ""
echo "DONE!"
echo "Files saved in /var/tmp/$file directory"
echo ""
sleep 1
# End of Script
