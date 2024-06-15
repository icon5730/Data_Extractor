An All-In-One Bash script designed to combine some of Kali Linux's Forensics tools (Binwalk, Foremost, Bulk Extractor, Strings & Volatility) in order to automate the Data Forensics process in Incident Response scenarios.

The script performs the following operations:
- Checks to make sure all tools are installed. If a tool is missing, the script attempts to install it.
- Takes an image file from the user to inspect.
- Generates an offset map using Binwalk and saves it in a timestamped folder.
- Carves data using Foremost and saves the data inside the timestamped folder.
- Uses Exiftool in order to generate metadata on the files carved using Foremost.
- Carves data using Bulk Extractor; checks if the carved data has a pcap file. If it finds one - saves the file inside the timestamped folder separate from the carved data.
- Examines the file for human-readable strings provided by the user.
- Checks if the file is a memory file. If it is - allows the user to generate data out of it based on user input while using Volatility.
- Generates a table of contents file inside the timestamped folder containing the folder's content, the date and time the analysis took place, and the time it took for the analysis to complete.
- Asks if the user wishes to zip the results.
- Ask the user whether they wish to examine another file. 

Notes: 
1. The script uses volatility_2.5.linux.standalone. If you wish to use a later version - the script needs to be modified to accommodate it.
2. Success of the tool installation segment may vary depending on the type of Linux Distro being used.

<b>Full Script Run:</b>

![1](https://github.com/icon5730/Data_Extractor/assets/166230648/995f9e2a-3432-4dbd-b0e6-26a1c4aebdee)
![2](https://github.com/icon5730/Data_Extractor/assets/166230648/0701db96-64f2-4ee4-857a-e0c54fb36863)

<b>Folder Contents:</b>

![3](https://github.com/icon5730/Data_Extractor/assets/166230648/86d136ba-cd2d-4cf2-b87b-df6a946f52ce)
![8](https://github.com/icon5730/Data_Extractor/assets/166230648/1db92f73-9944-431d-b664-9fedcb36dec8)
![9](https://github.com/icon5730/Data_Extractor/assets/166230648/3beead34-0739-4b6c-a2ee-7395367161f3)
![10](https://github.com/icon5730/Data_Extractor/assets/166230648/039a25e5-2a17-4d16-a0c8-ff0775d744e7)

<b>Generated File Contents:</b>

![4](https://github.com/icon5730/Data_Extractor/assets/166230648/21047b45-eb32-4264-b69d-cf75959b6af7)
![5](https://github.com/icon5730/Data_Extractor/assets/166230648/c78b5aa5-1c6d-4186-9220-f57869bab34c)
![6](https://github.com/icon5730/Data_Extractor/assets/166230648/d224ad98-d8e1-4d5f-add5-2dce77225070)
![7](https://github.com/icon5730/Data_Extractor/assets/166230648/be9132e4-d0ac-4969-925a-7ad40aaae86c)
