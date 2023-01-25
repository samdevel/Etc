#!/bin/csh
#
# Script logs output of commands to a file.
# Log file is placed under /var/log, and
# the name of the file is <router_host_name>.log
#
#Usage:
#1. Modify \x91cli_cmd\x92, \x91shell_cmd\x92, \x91vty_tgt\x92 and \x91vty_cmd\x92 accordingly
#2. Upload the file to a JUNOS firewall, and chmod to executable.
#3. /bin/csh debug_info.sh, to run the script.
#4. The result will be in /var/log/<hostname<processed>.log
#



# Fetch hostname and date
set host=`hostname`
set dt=`date`


# Log file name
set log_file="/var/log/$host""$$.log"

# CLI commands. Add CLI commands to this list. 
set cli_cmd = ( \
"set cli timestamp" \
"configure private; set interfaces ge-0/0/47.0 family inet address 10.10.10.1/30; commit" \

# "show interface extensive | no-more" \
# "show isis adjacency" \
# "show mpls interface detail" \
# "show mpls lsp detail" \
# "show bgp summary" \
# "show route protocol bgp " \
# "show chassis routing-engine" \
         )

		 
# RE shell commands. Add shell commands to this list.
#set shell_cmd=( \
#             "ps auxef" \
#            )

#Add VTY target/commands to this list.
set vty_tgt=( \
"fw dd"\
           )

set vty_cmd=( \
#"show usp flow counters all" \
# "show interfaces" \
#"show octeon cpu detail all" \
#"show octeon session detail" \
   )
   
   
#### Command execution ####

# Mark begin
echo "============ START ===========" >> $log_file
echo "DATE : $dt " >> $log_file
echo "" >> $log_file

# Gather CLI commands output first.
@ i=1
while ($i <= $#cli_cmd)
  echo "CLI CMD: $cli_cmd[$i]" >> $log_file
  echo "=================================================="            >> $log_file
  cli -c "$cli_cmd[$i] | no-more" >> $log_file
  echo "" >> $log_file
  @ i++
end

# Gather SHELL commands output.
#@ i=1
#while ($i <= $#shell_cmd)
#  echo "SHELL CMD: $shell_cmd[$i]" >> $log_file
#  echo "=================================================="            >> $log_file
#  $shell_cmd[$i] >> $log_file
#  echo "" >> $log_file
#  @ i++
#end


# Then, gather VTY commands output.
@ j=1
while ($j <= $#vty_tgt)
    @ i=1
    while ($i <= $#vty_cmd)
      echo "VTY CMD: $vty_tgt[$j] $vty_cmd[$i]"                         >> $log_file
      echo "=================================================="         >> $log_file
      /usr/sbin/cprod -A "$vty_tgt[$j]" -c "$vty_cmd[$i]"               >> $log_file
      echo "" >> $log_file
      @ i++
    end
@ j++
end
echo "End Of Test"

