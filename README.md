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

![1](https://github.com/icon5730/Data_Extractor/assets/166230648/bfc2c91d-5ad0-47ba-801a-7e7aadf25a03)
![2](https://github.com/icon5730/Data_Extractor/assets/166230648/61fd5c80-aa89-4d7c-b9da-bfbe34d7de20)

<b>Folder Contents:</b>

![3](https://github.com/icon5730/Data_Extractor/assets/166230648/c536ef72-e0a7-4c2f-b538-a8c57400ba58)
![4](https://github.com/icon5730/Data_Extractor/assets/166230648/abd3a0b3-1d8d-409c-9f72-093c9d4bf69a)
![5](https://github.com/icon5730/Data_Extractor/assets/166230648/28435bd7-cf5d-466a-a5e6-a2507a4c7b8b)
![6](https://github.com/icon5730/Data_Extractor/assets/166230648/43bd2084-39bc-41ad-9163-a0707c066928)
![7](https://github.com/icon5730/Data_Extractor/assets/166230648/a0e990de-a900-47ec-a55d-08614148bd47)


<b>Generated File Contents:</b>

![8](https://github.com/icon5730/Data_Extractor/assets/166230648/5f11b31c-417a-4dac-817a-828b270615e3)
![9](https://github.com/icon5730/Data_Extractor/assets/166230648/d2f8a787-2564-44e4-9aee-492a72550afc)
![10](https://github.com/icon5730/Data_Extractor/assets/166230648/acee3349-b72f-4366-b210-0bbb54a4ce1d)
![11](https://github.com/icon5730/Data_Extractor/assets/166230648/accadda8-74ef-4420-b9af-cb219660c9a6)

