#define TCP/IP protocol(IP address- MAC adress - subnet mast - gateway) for my machine for all NFCs 
ifconfig  

#to check connectivity between my machine and any ip 
ping www.google.com  #or by ip 

# the resolution between every MAC and IP
arp   #Address Resolution Protocol

# to connect to file server (up and down files)
ftp  					  #File Transfer Protocol
	> open ftp.microsoft.com  # entry with usr name and password
	> bye					  # for exit

#for get IP address for any site
nslookup 
	> www.google.com
		Server:		192.168.1.1
		Address:	192.168.1.1#53

		Non-authoritative answer:
		Name:	www.google.com
		Address: 172.217.18.36
	> exit

#to recognize the routing table components of my device
route

# show all my device connections 
netstate

# to scan ports
nmap 127.0.0.1 
nmap -p 1-65535 127.0.0.1    	# -p to choose a range
nmap -p 1-65535 -m 10 127.0.0.1 # -m to issues several prob requests at the same time
# Scanning Multiple Hosts 
nmap host1 host2 host3          # by names or ip
nmap 192.168.1.*                # warning: never try to scan *.*.*.*  on any machine connected to the Internet
nmap 192.168.1.0/24				# by CIDR notation
# scanning ranges
nmap 192.168.1.10-35
nmap 192.168.1,2,3,4.10
nmap 192.168.1,2.3,4.10-35           
# nmap flags and options
-sT 				Perform a full open TCP scan 
-sS 				Perform a SYN (stealth) TCP scan 
-sU 				Perform a UDP scan 
-sR or -sV 			Perform an RPC service scan (should be used in conjunction with another scan type) 
-A 					aggressive scan for more info
-O 					Try remote OS detection 
-O --osscan-guess 	guess the OS if not detected
-P0 				Donít try to see if a host is up before scanning it 
-p 					<port range> Specify a range of ports to scan 
-M 					<max connections> The maximum number of parallel connection attempts to make at one time. For LANs, should be no more than 18. For slow links (WAN, Internet), this can be significantly higher. 

# to capture and analyze network traffic going through your system and for troubleshooting
tcpdump 
-x 							# display all packet in hex
-s 1500						# snap length ,1500 byte,if 0 means show all packet
-w file  					# to write in file
-r file 					# to read tcpdump data
 