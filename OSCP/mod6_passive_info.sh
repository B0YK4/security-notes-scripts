##the harvester tool
#find mails related to domain 
theHarvester -d domain.com -b google,bing,..


____searching_tools____
##google dorks 
#for hackers dedicated searching

##FOCA tool: GUI in Windows

____serching_in_stored_bachup_data____
#even if the site is down or the data is deleted
## web.archive.org
## wayback tool

__________whois_enumeration___________
#gives us info about site 
'by searching in any whois site or using whois command'
whois megacorpone.com
whois 38.100.193.70		#reverse lookup 

__________subdomain_enumeration___________
#pre info 
'classless inner-domain roting:CIDR' 	#ip range for orga. represented by subnet-mask ex:192.168.1.0/24
'Autonomous system number: ASN'			#const number represent org. traffic via internet ex:45155  
"find CIDR and ASN from [site: bgp.he.net] "	#++ find all cidr by ASN with whois command

## amass tool
amass intel -org uber 			#find ASN for any org
amass intel -asn 45155      	#find all domains related to this ASN
amass intel -cidr 3.1.0.0/16	#find all domains related to this CIDR
amass intel -whois -d domain.com 	#find all other domain registers by doamin.com owner
#find subdomains passive&active
amass enum -passive -d domain.com 		#finds all subdomains
amass enum -active -d domain.com 		#finds active subdomains only

##sublist3r (eng ahmed abo-el3la)
#find subdomains in faster way
sublist3r -d domain.com 


__________open-source_enumeration___________
##github as ex for open source codes 
'serch in github with company name and others keywords as like as google dorks'
- "uber" passwd
- "uber" config
- "uber" token
...

##pastebin
'site for: leaked data, accounts ...'
'advanced: using pastebin API by register with pro account'

##stack over flow smetimes we can find parts of code help us in our enumeration
'searching like in github'

##scripts to find leaked info 
- gitrob
- gitleaks

## sites search for any thing connected to the internet belong to the company: ips, opened ports, vulnerabilities ...
- shodan.io   #provides searching by dorks
- censys.io

##site for check if email have been leaked
- haveibeenpwned.com

__________tools-and-sites-libraries____________
##OSINT framework
osintframework.com    #all free sites and tolls

##maltego tool
maltego   #graphical tool in kali for multi info gathering types