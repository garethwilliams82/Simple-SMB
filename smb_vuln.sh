#!/bin/bash
echo "Enter a IP or Subnet:"
read i

echo "Scanning" $i "Please wait...."

nmap --script smb-vuln* -Pn -p 139,445 $i -oN nmap_smb_vuln.txt >/dev/null

echo "Completed. File saved as: results.txt"

cat nmap_smb_vuln.txt | egrep 'State:|report|IDs|open|smb-vuln' > results.txt
rm nmap_smb_vuln.txt

echo "Would you like to see the NMAP SMB Vuln scan results?"
read answer

if [ $answer = "Y" ] || [ $answer = "y" ]; then
	cat results.txt
else
	exit
fi

echo "Looking for shared folders, please wait......"
smbmap -H $i > smb_results.txt

cat  smb_results.txt | egrep 'IP|Disk|NO ACCESS|READ|WRITE' > smbresults.txt
rm smb_results.txt

echo "Would you like to see the SMBMAP results?"

if [ $answer = "Y" ] || [ $answer = "y" ]; then
	cat smbresults.txt
else
	exit
fi