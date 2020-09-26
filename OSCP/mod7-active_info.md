# DNS enumeration 
ip look up
```sh
$ host -t A dns.google 		#lookup
$ host -t PTR 8.8.8.8 		#reverse lookup
```
#### host records more than 30 record
```sh
A-PTR-CNAME-MX(domain that handel the server)-ns..
```

### all text data needed for bruteforce
`seclists`, installed in linux and used with commands or we can use the data from github
```sh
$ seclists 			
```

### zone transfers
to get more info about target domains and the internal network
```sh
$ host -l <domain> <dns server address>
```
to get dns servers addresses and try bruteforce the domain named if you got no ns records with (-t ns)
```sh
$ host -t ns <domain>
```

### DNS recon
dns recon tool in linux
```sh
$ dnsrecon -d <doamin>
$ dnsenum -d <domain> -D <bruteforce text file> -brt 
```
# nmap
> ...
# masscan
> ...
# smb & netbios enumeration
>`SMB` 'server message block' protocol > **internal blue vulnra.**
### scanning for netbios service
`nbtscan` 
```sh
$ nbtscan -r 192.168.1.0/24 -v
```
### connecting to machine as smb client 
`smbclient` 
annonimus login
```sh
$ smbclient -L 192.168.1.5 
$ smbclient //192.168.1.5/folder
```
login with user and passwd
```sh
$ smbclient //192.168.1.5/folder -U user -P passwd
```
`smbmap` better than *smbclient*
annonimus login
```sh
$ sudo smbmap -H 192.168.1.5
$ sudo smbmap -H 192.168.1.5 -u anyusername
```
login with user and passwd and also provides login with hashed passwd
```sh
$ sudo smbmap -H 192.168.1.5 -u username -p passwd
```
`enum4linux` does the same job but gives more info
```sh
$ sudo enum4linux 192.168.1.5 -a -v
```
enum with `nmap` scripts 
```sh
$ ls /usr/share/nmap/scripts/smb
$ sudo nmap 192.168.1.5 -sV -p T:139,445 U:137 --script="smb-enum-*"
$ sudo nmap 192.168.1.5 -sV -p T:139,445 U:137 --script="smb-vuln-*"
```
# NFS enumeration
>Network File System (NFS) allows a user on a client computer to access files 
>over a computer network as if they were on locally-mounted storage.
>Portmapper214 and RPCbind215 run on `TCP port 111`,The rpcbind service redirects the client to the proper port number (often TCP port 2049)
 We can scan these ports with `nmap` on **metasploitable** machine
```sh
$ nmap -v -p 111 192.168.87.131
```
to show all nfs rpc info 
```sh
$ nmap -sV -p 111 --script nfsinfo 192.168.87.131
```
if we didn't get any result we can do it with `rpcinfo` command and we can show exported mount files with `showmount` command
```sh
$ rpcinfo -p 192.168.87.131
$ showmount -e 192.168.87.131
``` 
In this case, the entire `/home` directory is being shared and we can access it by mounting it on our 
Kali virtual machine. We will use mount to do this, along with `-o nolock `to disable file locking, 
which is often needed for older NFS servers
```sh
$ mkdir /tmp/nfs/home
$ sudo mount -o nolock 192.168.87.131:/home /tmp/nfs/home/
$ ls /tmp/nfs/home
```
if there is a file with UUID `-rwx------ 1 1014 1014 48 Jun 10 09:16 file.txt` we can try to add a local user to it using the **adduser** command, change its UUID to the file id
```sh
$ sudo adduser pwn
$ sudo sed -i -e 's/1001/1014/g' /etc/passwd
$ su pwn
$ id
$ cat /tmp/nfs/home/msfadmin/file.txt
```

# SMTP enumeration 
>The Simple Mail Transport Protocol (SMTP) supports several interesting commands, such as VRFY and 
>EXPN. A VRFY request asks the server to verify an email address, while EXPN asks the server for 
>the membership of a mailing list. These can often be abused to verify existing users on a mail server
```sh
$ nc -nv 192.168.87.131 25
VRFY root
VRFY msfadmin
``` 
python script to VRFY SMTP users takes username as argument
```py
#!/usr/bin/python
import socket
import sys

if len(sys.argv) != 2:
 print "Usage: vrfy.py <username>"
 sys.exit(0)

# Create a Socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to the Server
connect = s.connect(('10.11.1.217',25))

# Receive the banner
banner = s.recv(1024)
print banner

# VRFY a user
s.send('VRFY ' + sys.argv[1] + '\r\n')
result = s.recv(1024)
print result

# Close the socket
s.close()
```
takes a file contains users names to VRFY
```py
#!/usr/bin/python
import socket
import sys

if len(sys.argv) != 2:
 print "Usage: vrfy.py <username>"
 sys.exit(0)

# Create a Socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to the Server
connect = s.connect(('10.11.1.217',25))

# Receive the banner
banner = s.recv(1024)
print banner

#!/usr/bin/python
import socket
import sys

if len(sys.argv) != 2:
	print "Usage: vrfy.py <username>"
	sys.exit(0)

# Create a Socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to the Server
connect = s.connect(('10.11.1.217',25))

# Receive the banner
banner = s.recv(1024)
print banner

# Using readlines() 
file1 = open(sys.argv[1], 'r') 
Lines = file1.readlines() 
  
# Strips the newline character 
for line in Lines: 
	# VRFY a user
	s.send('VRFY ' + line.strip() + '\r\n')
	result = s.recv(1024)
	print result

# Close the socket
s.close()
```
with linux tool `smtp-user-enum` or `nmap scripts`
```sh
$ sudo apt install smtp-user-enum
```
# SNMP enumeration
>the Simple Network Management Protocol (SNMP) is not well-understood by many network administrators. 
>This often results in SNMP misconfigurations, which can result in significant information leakage.
>SNMP is based on UDP, a simple, stateless protocol, and is therefore susceptible to IP spoofing and replay attacks. 
>The SNMP Management Information Base (MIB) is a database containing information usually 
>related to network management. The database is organized like a tree, where branches represent 
>different organizations or network functions. 
To scan for open SNMP ports, we can run `nmap` as shown
```sh
$ sudo nmap -sU --open -p 25 192.168.87.133 -oG SNMPout.txt
```
Alternatively, we can use a tool such as `onesixtyone`, which will attempt a brute force attack against a list of IP addresses. 
```sh
$ onesixtyone -c communityString.txt -i ips.txt
```
We can probe and query SNMP values using a tool such as `snmpwalk` provided we at least know the SNMP read-only community string, which in most
cases is “public”.
```sh
$ snmpwalk -c public -v1 -t 10 192.168.87.133
```
enumeration by `metasploit`
```sh
$ sudo msfdb start
$ msfconsole
>search SNMP
>use 12
>show options
>set RHOSTS 182.168.87.133
>exploit
```

