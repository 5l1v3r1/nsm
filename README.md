# nsm
Nessus Statistics Maker
## Instructions
1. In the Excel Nessus report do a ```CTRL+F```, click "Replace" tab and "Replace All"
2. In the Search Box input put the cursor and hit ```CTRL+j```
  In the Replace With input box, put comma and space: ```, ```
3. Save the file as CSV
4. Pass file as argument to this script.
## Example
```
root@demonv2.4:~# ./nsm.sh new_report.csv
Parsing file: new_report.csv 	[ OK ]
Stats for new_report.csv:
----------------------------------

[Critical]..15 (.6900%)
[High]......47 (2.1700%)
[Medium]....1860 (85.9100%)
[Low].......243 (11.2200%)

[Total Findings]: 2165
```
## Dependencies
This application relies on ```bc``` to calculate the floating point values used for percentages.
