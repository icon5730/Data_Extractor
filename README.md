An All-In-One Bash script designed to combine some of Kali Linux's Forensics tools (Binwalk, Foremost, Bulk Extractor & Volatility) in order to automate the Forensics process.

The script performs the following operations:
- Checks in order to make sure all tools are installed. If a tool is missing, the script attempts to install it.
- Takes an image file from the user to inspect.
- Generates an offset map using Binwalk and saves it in a timestamped folder.
- Carves data using Foremost and saves the data inside the timestamped folder.
- Carves data using Bulk Extractor; checks if the carved data has a pcap file. If it finds one saves the file inside the timestamped folder separate from the carved data.
- Examines the file for strings provided by the user.
- Checks if the file is a memory file. If it is - allows the user to generate data out of it based on user input.
- Generates a table of content file inside the timestamped folder, containing the folder's content, the date and time the analysis took place, and the time it took for the analysis to complete.
- Asks if the user wishes to zip the results.
- Ask the user whether they wish to examine another file. 

Notes: 
-The script uses volatility_2.5.linux.standalone. If you wish to use a different version - the script needs to be modified to accommodate it.
-Success of the tool installation segment may vary depending on the type of Linux being used.
