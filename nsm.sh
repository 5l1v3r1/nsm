#!/usr/bin/env bash
# get stats from Nessus scans
# 2020 Douglas Berdeaux, weaknetlabs@gmail.com
# Usage: ./nsm.sh <FILE.CSV>
# Deps: bc, "apt install bc"
#
# 1. In the Excel Nessus report do a CTRL+F, click "Replace" tab and "Replace All"
# 2. In the Search Box input put the cursor and hit CTRL+j
# 	In the Replace With input box, put comma and space: ", "
# 		without the quotes.
# 3. Save the file as CSV
# 4. Pass file as argument to this script.
#
export usage='\nUsage: ./nsm.sh <FILE>\n\n'
if [[ "$1" == "" ]] 
then
	printf "$usage"
else
	Nessus_File_CSV=$1
	if [[ -f "$Nessus_File_CSV" ]]
	then
		printf "Parsing file: $Nessus_File_CSV "
		export Crit=$(awk -F, '{print $4}' $Nessus_File_CSV|egrep -i 'Critical'|wc -l)
		export High=$(awk -F, '{print $4}' $Nessus_File_CSV|egrep -i 'High'|wc -l)
		export Med=$(awk -F, '{print $4}' $Nessus_File_CSV|egrep -i 'Medium'|wc -l)
		export Low=$(awk -F, '{print $4}' $Nessus_File_CSV|egrep -i 'Low'|wc -l)
	
		export total=$(($Crit + $High + $Med + $Low))
	
		export Crit_p=$(echo "scale=4; $Crit/$total * 100" | bc )%%
		export High_p=$(echo "scale=4; $High/$total * 100" | bc )%%
		export Med_p=$(echo "scale=4; $Med/$total * 100" | bc )%%
		export Low_p=$(echo "scale=4; $Low/$total * 100" | bc )%%
		
		printf "\t[ OK ]\n"
	
		printf "Stats for $Nessus_File_CSV:\n"
		printf -- "----------------------------------\n\n"
		printf "[\e[31mCritical\e[39m]..$Crit ($Crit_p)\n"
		printf "[\e[93mHigh\e[39m]......$High ($High_p)\n"
		printf "[\033[0;33mMedium\e[39m]....$Med ($Med_p)\n"
		printf "[\e[32mLow\e[39m].......$Low ($Low_p)\n" 
	
		printf "\n[Total Findings]: $total\n\n"
	else
		printf "\n[ ERROR ]: Could not open file: $Nessus_File_CSV\n\n"
	fi
fi
