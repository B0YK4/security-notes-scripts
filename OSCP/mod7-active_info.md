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
>Portmapper214 and RPCbind215 run on `TCP port 111`

