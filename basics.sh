#### commands info
man ls 			    # manual and all "ls" info
whatis ls 		    # quit description for what is ls 
apropos list        		# search what tool to do this function
whoami
sudo adduser mohamed 		# add user
usermod -aG sudo mohamed 	# add sudo user
shasum  file 				# see file hashing


### file mangement  1-ordinary files 2- special files 3-directories  

pwd 				# current directory
ls  				# list
ls -l  				#  with all informations
ll
ls -il
ls -a 				# with all hidden files
ls -i 				#  inode number of files (index of file)
find /home/boyka -inum 1150561 #find file with inode number

### creating files

cat>file_name 		# Create a file and enter data and ctrl+D to save the file 
cat file_name 		# display the file data 
touch file_name2    # create and save empty file

### move - rename - copy - delete

mv file_name file_name_new					   # rename a file or move the file
mv file_name /home/boyka/Desktop
mv * /home/boyka/Desktop 					   # use regex to selet more than file to move
mv f* /home/boyka/Desktop
mv /home/boyka/Desktop/file_name .             # . mean the final same location of the file 
cp file_name /home/boyka/Desktop 			   # copy 
cp file_name /home/boyka/Desktop/file_name_new # copy with new name
rm file_name file_name2 					   # delete specific files
rm * 										   # delete all files

### display files

cat file_name 		# dispay file data
wc file_name 		# display (n1 n2 n3 file_name) its count (line_num  words_num  char._num)
wc -l file_name 	# number of lines
wc -w file_name 	# number of words
wc -c file_name 	# number of char.

### standard linux streams (this built-in files work when we creating script or program)

stdin 				# (0) this file take the input
stdout 				# (1) giving the output
stderr 				# (2) work and detect errors

### directory mangement [hidden files get crated by defalult when create directory { (.)-the informations of current dir (..)-the information of level above dir }]

cd 					# change directory
cd .. 				# step back
mkdir 				# make directory
mkdir boyka\ tasks  # \ to make directory with space separate name (boyka tasks)
ls -la 				# show detail informations with hidden files/directories
mv -r 				
cp -r 

### permissions [ owner - group - other ] >>( read - write - execute )

# [file/dir|owner|group|other]
-rwxr-xr-x          # [-] file
drwxr-xr--  	    # [d] dir

# change with symbolic method [u: user / g: group / o:others]
chmod u+x file_name   		# add permission to user
chmod u-wx file_name		# remove permission from user
chmod u=rwx file_name		# set the permissions of user
chmod u+x,g-w,o=r file_name
chmod a=rwx file_name 		# set for all (u,g and o)

# with octal mehod [0:--- , 1:--x , 2:-w- , 3:2+1 , 4:r-- , 5:4+1 , 6:4+2 , 7:4+2+1]
chmod 775 file_name   		# 7 for user , 6 for group and 5 for other
umask 						# (0002) get the number that represent the default permissions for new files or dir created [7777-umask=permissions_num]
umask 027  					# change umask number [7777-7027=0750] umask_new=0750

### Environment Variables
env                         # show the default variables declars in the environment
env  boyka="kshckhdjoj"     # declare my own env. variable

.profile                    # the file that run automaticaly when you start .... if it contains nothing the system skiped it and go to home directory
.bash_history               # bash comands history
.bash_logout                # log out task


### Basic Utilities ( printing - sending a mail) 
#   mails in localhost >> var/spool/mail

pr option(s) file(s)        # ex: pr -2 file | more  >> this will make two colomns
lpr file                    # send to printer
 
$ mail -s “Enter the subject” user1@domain.com
$ mail -s “The Subject” user1@domain.com < /root/testemail.txt  # Send message from a file
$ echo “THIS IS A TEST EMAIL” | mail -s “Enter the subject” user1@domain.com 
$ echo “THIS IS A TEST EMAIL” | mail -s “Enter the subject” user1@domain.com,user2@domain.com  # Multiple recipients
$ echo “THIS IS A TEST EMAIL” | mail -s “Enter the subject” -c user1@domain.com,user2@domain.com # CC and BCC
$ echo “THIS IS A TEST EMAIL” | mail -s “Enter the subject” –r “Tom<tom@gmail.com>” user1@domain.com # Specify From name and address
#  Specify “Reply-To” address
    $ echo “THIS IS A TEST EMAIL” | mail -s “Enter the subject” replyto= tom@gmail.com user1@domain.com

    $ echo “THIS IS A TEST EMAIL” | mail -s “Enter the subject” replyto= “Tomtom@gmail.com” user1@domain.com
# Attachments

The option –a is used to add an attachment along with the email.

    $ echo “THIS IS A TEST EMAIL” | mail -s “Enter the subject” –r “Tom<tom@gmail.com>” –a /path/to/file user1@domain.com


### pipes and filters

# pipe >>>>   A pipe is a means by which the output from one process becomes the input to a second. In technical terms,
#             the standard output (stout) of one command is sent to the standard input (stdin) of a second command

command_1 | command_2 | command_3 | .... | command_N 
$ ls -l | more                          # list and get the --more-- option == {  ls -l > temp , more < temp , rm temp}
$ sort record.txt | uniq                # This will sort the given file and print the unique values only
$ cat sample2.txt | head -7 | tail -5   # select first 7 lines and last 5 lines from the file and print those lines which are common to both of them
$ ls -l | find ./ -type f -name "*.txt" -exec grep "program" {} \; # select files with .txt extension in the given directory 
                                                                   # and search for pattern like “program” in the above example and print those ine which have program in them
$ cat result.txt | grep "Rajat Dua" | tee file2.txt | wc -l     # select Rajat Dua and store them in file2.txt and print total number of lines matching Rajat Dua


# filter >>>> A pipe can pass the standard output of one operation to the standard input of another, 
#             but a filter can modify the stream. A filter takes the standard input, does something useful with it,
#             and then returns it as a standard output. Linux has a large number of filters. 
#             Some useful ones are the commands awk, grep, sed, spell, and wc. 

 head -n      # Show the first n lines.
 tail -n      # Show the last n lines.
 sort         # Sort lines in a given way [sort -n file , sort -r file , sort -nr , sort -f ].
 wc           # How many words, characters and lines.
 grep         # Search for a given pattern.



 ### File editors [ ex. : gedit - nano - vi,vim ]

 #Parameters
 #Variable Name Description
$0 			The name of the Bash script
$1 - $9 	The first 9 arguments to the Bash script
$# 			Number of arguments passed to the Bash script
$@ 			All arguments passed to the Bash script
$? 			The exit status of the most recently run process
$$ 			The process ID of the current script
$USER 		The username of the user running the script
$HOSTNAME 	The hostname of the machine
$RANDOM 	A random number
$LINENO 	The current line number in the script
 
 #Operator Description: Expression True if…
!EXPRESSION 			The EXPRESSION is false.
-n STRING 				STRING length is greater than zero
-z STRING 				The length of STRING is zero (empty)
STRING1 != STRING2 		STRING1 is not equal to STRING2
STRING1 = STRING2 		STRING1 is equal to STRING2
INTEGER1 -eq INTEGER2 	INTEGER1 is equal to INTEGER2
INTEGER1 -ne INTEGER2 	INTEGER1 is not equal to INTEGER2
INTEGER1 -gt INTEGER2 	INTEGER1 is greater than INTEGER2
INTEGER1 -lt INTEGER2 	INTEGER1 is less than INTEGER2
INTEGER1 -ge INTEGER2 	INTEGER1 is greater than or equal to INTEGER 2
INTEGER1 -le INTEGER2 	INTEGER1 is less than or equal to INTEGER 2
-d FILE 				FILE exists and is a directory
-e FILE 				FILE exists
-r FILE 				FILE exists and has read permission
-s FILE 				FILE exists and it is not empty
-w FILE 				FILE exists and has write permission
-x FILE 				FILE exists and has execute permission