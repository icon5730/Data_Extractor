An All-In-One Bash script designed to combine some of Kali Linux's Forensics tools (Binwalk, Foremost, Bulk Extractor & Volatility) in order to automate the data Forensics process.

The script performs the following operations:
- Checks to make sure all tools are installed. If a tool is missing, the script attempts to install it.
- Takes an image file from the user to inspect.
- Generates an offset map using Binwalk and saves it in a timestamped folder.
- Carves data using Foremost and saves the data inside the timestamped folder.
- Carves data using Bulk Extractor; checks if the carved data has a pcap file. If it finds one saves the file inside the timestamped folder separate from the carved data.
- Examines the file for human-readable strings provided by the user.
- Checks if the file is a memory file. If it is - allows the user to generate data out of it based on user input.
- Generates a table of contents file inside the timestamped folder containing the folder's content, the date and time the analysis took place, and the time it took for the analysis to complete.
- Asks if the user wishes to zip the results.
- Ask the user whether they wish to examine another file. 

Notes: 
1. The script uses volatility_2.5.linux.standalone. If you wish to use a different version - the script needs to be modified to accommodate it.
2. Success of the tool installation segment may vary depending on the type of Linux being used.

![1](https://github.com/icon5730/Data_Extractor/assets/166230648/bca14fe7-319f-4af8-9d45-69d637a0e8b0)
![2](https://github.com/icon5730/Data_Extractor/assets/166230648/3eadefbd-c6e4-4da1-bd4b-45c67f4a119c)
![3](https://github.com/icon5730/Data_Extractor/assets/166230648/0ee86e07-e2d7-4d9a-98a4-f309a4f36ae3)
![4](https://github.com/icon5730/Data_Extractor/assets/166230648/1f787042-9639-484f-be47-606ccea0aff8)
![5](https://github.com/icon5730/Data_Extractor/assets/166230648/3c1fa31e-5910-4f7b-9631-b8cdfdbf03b3)
