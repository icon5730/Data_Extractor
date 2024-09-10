An All-In-One Bash script designed to combine some of Kali Linux's Forensics tools (Binwalk, Foremost, Exiftool, Bulk Extractor, Strings & Volatility) in order to automate the Data Forensics process in Incident Response scenarios.

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
- Generates a full timed Operations Log, timestamping every operation the script ran.
- Asks if the user wishes to zip the results.
- Ask the user whether they wish to examine another file. 

Notes: 
1. The script uses volatility_2.5.linux.standalone. If you wish to use a later version - the script needs to be modified to accommodate it.
2. Success of the tool installation segment may vary depending on the type of Linux Distro being used.

<b>Full Script Run:</b>

![1](https://github.com/user-attachments/assets/d9db4913-d816-4b59-bcf1-00cf29d4014a)
![2](https://github.com/user-attachments/assets/09fe4620-8870-4900-8e24-5a253e5c44df)

<b>Installation Checkup on a different Linux Distribution:</b>

![12](https://github.com/user-attachments/assets/8e09cc62-ffce-4d8b-a517-d063126eeaab)

<b>Folder Contents:</b>

![3](https://github.com/user-attachments/assets/f2283502-7188-442b-b823-08836734cc0f)
![4](https://github.com/user-attachments/assets/4e80aab4-b983-4ba3-addf-b34d407bd3b9)
![5](https://github.com/user-attachments/assets/f92e69e5-9d03-4375-a411-fa6d9827c1b1)
![6](https://github.com/user-attachments/assets/82ae11c9-e850-4a27-b0ff-8d3496b15588)
![7](https://github.com/user-attachments/assets/20a05bdb-9f2b-4786-95d3-e58923a5c068)

<b>Generated File Contents:</b>

![8](https://github.com/user-attachments/assets/e3690733-c5e7-4506-aff5-e771b4793627)
![9](https://github.com/user-attachments/assets/bcda2b5b-787a-464b-a8d8-20f84e47bfff)
![10](https://github.com/user-attachments/assets/6723b2f9-57aa-4904-87ad-3fa1e9e5f124)
![11](https://github.com/user-attachments/assets/ee302583-36be-4b07-b194-4f32e70e492a)
