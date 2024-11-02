#!/bin/bash



red="\e[31m"    		#Color variables to be used in the script                        
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
cyan="\e[36m"
endcolor="\e[0m"



#The first function's main purpose is to make sure the script runs with root privileges. If the user is not root, the script alerts the user and terminates in order for the user to restart it properly. 
function privileges (){
if [[ $(id -u) -ne 0 ]]; then
                echo -e "$red[!] WARNING!!! \nThis script must run with root privileges. \nPlease restart the script under root. \nTerminating script operations...$endcolor"
                exit 1
fi


}



#This is just a prompt function. It is used as a function in order to be called only if the previous function allows the script to continue.
function commence(){
echo -e "$yellow*******************************************************************************$endcolor"
echo -e "$yellow*******************************************************************************$endcolor"
echo -e "$yellow*******************COMMENCING INSTALLATION TOOL CHECKUP:***********************$endcolor"
echo -e "$yellow*******************************************************************************$endcolor"
}

#This function tests the existence of figlet by examining the existence of its command. The inability to find the command would show that the program is not installed, prompting its installation.

function installation1(){
if ! command -v figlet &> /dev/null ;then
        echo -e "$red[!] Figlet is not installed$endcolor" ; sleep 0.2
        echo -e "$yellow[+] Installing Figlet $endcolor"
        sudo apt install figlet -y &> /dev/null
        	if ! command -v figlet &>/dev/null ; then echo -e "$red[!] Failed to install figlet $endcolor" 
			else echo -e "$green[*] Figlet is installed$endcolor" ; sleep 0.2
                fi
         else echo -e "$green[*] Figlet is already installed$endcolor" ; sleep 0.2
fi
}

#Same concept as the previous function, only for Foremost.
function installation2(){

if ! command -v foremost &> /dev/null ;then
        echo -e "$red[!] Foremost is not installed$endcolor" ; sleep 0.2
        echo -e "$yellow[+] Installing Foremost $endcolor"
        sudo apt install foremost -y &> /dev/null
		if ! command -v foremost &>/dev/null ; then echo -e "$red[!] Failed to install Foremost $endcolor"
                	else echo -e "$green[*] Foremost is installed$endcolor" ; sleep 0.2
		fi
	else echo -e "$green[*] Foremost is already installed$endcolor" ; sleep 0.2
fi
}

#Same concept as the previous installation functions, only for Bulk Extractor.
function installation3(){
if ! command -v bulk_extractor &> /dev/null ;then
	echo -e "$red[!] Bulk Extractor is not installed$endcolor"
	echo -e "$yellow[+] Installing Bulk Extractor $endcolor"
	git clone --recurse-submodules https://github.com/simsong/bulk_extractor.git &> /dev/null
	apt-get install libre2-dev &> /dev/null
	cd bulk_extractor 
	./bootstrap.sh &> /dev/null
	./configure &> /dev/null
	make &> /dev/null
	make install &> /dev/null
	cd ..
        if ! command -v bulk_extractor &> /dev/null ; then echo -e "$red[!] Failed to install Bulk Extractor $endcolor" ; sleep 0.2
			else echo -e "$green[*] Bulk Extractor is installed$endcolor" ; sleep 0.2
		fi
	else echo -e "$green[*] Bulk Extractor is already installed$endcolor" ; sleep 0.2
fi
}

#Same concept as the previous installation functions.
function installation4(){
if ! command -v strings &> /dev/null ;then
	echo -e "$red[!] Strings is not installed$endcolor"
	echo -e "$yellow[+] Installing Strings $endcolor"
	sudo apt install strings -y &> /dev/null
		if ! command -v strings &> /dev/null ; then echo -e "$red[!] Failed to install strings $endcolor" ; sleep 0.2
			else	echo -e "$green[*] Strings is installed$endcolor" ; sleep 0.2
		fi
	else echo -e "$green[*] Strings is already installed$endcolor" ; sleep 0.2
fi
}

#This function tries to locate the Volatility executable, now named vol. If it fails to locate the file, it dnowloads Volatility, unzips it, and renames the exacutable to vol. 
function installation5(){

voli=$(find /home/ -type d -name "volatility_2.5.linux.standalone" | head -n 1 2>/dev/null)
if [[ ! $voli ]]; then
        echo -e "$red[!] Volatility is not installed$endcolor"
        echo -e "$yellow[+] Installing Volatility $endcolor"
        wget http://downloads.volatilityfoundation.org/releases/2.5/volatility_2.5.linux.standalone.zip &> /dev/null
	unzip volatility_2.5.linux.standalone.zip &> /dev/null
	mv ./volatility_2.5.linux.standalone/volatility_2.5_linux_x64 ./volatility_2.5.linux.standalone/vol &> /dev/null
	volfile=$(find -type f -name vol)
	if [ -f $volfile ]; then echo -e "$green[*] Volatility is installed$endcolor" ; sleep 0.2
		else echo -e "$red[!] Failed to install Volatility $endcolor"
	fi
        else echo -e "$green[*] Volatility is already installed$endcolor"
        sleep 0.2
fi
}
function installation6(){
if ! command -v tree &> /dev/null ;then
	echo -e "$red[!] Tree is not installed$endcolor"
	echo -e "$yellow[+] Installing Tree$endcolor"
	sudo apt install tree -y &> /dev/null
		if ! command -v tree &> /dev/null ; then echo -e "$red[!] Failed to install Tree $endcolor" ; sleep 0.2 
			else echo -e "$green[*] Tree is installed$endcolor" ; sleep 0.2
		fi
	else echo -e "$green[*] Tree is already installed$endcolor" ; sleep 0.2
fi
}
function installation7(){
if ! command -v exiftool &> /dev/null ;then
        echo -e "$red[!] Exiftool is not installed$endcolor" ; sleep 0.2
        echo -e "$yellow[+] Installing Exiftool $endcolor"
        sudo apt install libimage-exiftool-perl -y &> /dev/null
                if ! command -v exiftool &>/dev/null ; then echo -e "$red[!] Failed to install Exiftool $endcolor"
                        else echo -e "$green[*] Exiftool is installed$endcolor" ; sleep 0.2
                fi
        else echo -e "$green[*] Exiftool is already installed$endcolor" ; sleep 0.2
fi
}

function test(){

if ! command -v figlet &>/dev/null || ! command -v foremost &>/dev/null || ! command -v strings &>/dev/null || ! command -v bulk_extractor &>/dev/null || -f $voli &>/dev/null || ! command -v exiftool &> /dev/null
        then
        echo -e "$red[!] One or more of the tools needed to run this script was not installed and required an autoinstall attempt$endcolor"
        read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to run the script anyway? [Y/N] $endcolor")" choice
		case $choice in
		Y) text
		;;
		y) text
		;;
		N) echo -e "$cyan[*]$endcolor$red Exiting..."
        	sleep 0.3
        	exit 1
		;; 
		n) echo -e "$cyan[*]$endcolor$red Exiting..."
                sleep 0.3
                exit 1 
		;;
		*) echo -e "$red[!] Invalid choice. Exiting...$endcolor"
		sleep 0.3
		exit 1
		esac
        else
	text
fi
}
#This is just a text function to let the user know everything is installed, and to feature the script name: Data Extractor.
function text(){

echo -e "$yellow*******************************************************************************$endcolor"
echo -e "$yellow***********EVERYTHING IS GOOD TO GO, PROCEEDING TO SCRIPT OPERATIONS:**********$endcolor"
echo -e "$yellow*******************************************************************************$endcolor"
echo -e "$yellow*******************************************************************************$endcolor"

printf $blue
figlet "Data Extractor"
printf $endcolor
sleep 0.2
analyze
}


#The main function of the script. Everything was put into one function in order to allow looping it once the script is complete.
function analyze (){
#Timestamp (ts) is set in order to timestamp the output folder, and later the zip file.
ts=$(date +%a_%b.%d_%Y_%H:%M:%S)

read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please specify an image path of the file you wish to inspect: $endcolor")" path
#Using the date command in order to later calculate the elapsed time.
start_time=$(date +%s)
#This part of the function checks if a file exists in the path provided by the user. If a file exists, it alerts the user, creates an output folder and starts running Foremost and Bulk Extractor on the file. Folders are created and moved inside the output folder in order to store the output data. If a file doesn't exist, the user is alerted and the script terminates.
	if [ -f $path ];
		then
		echo -e "$green[!] Path contains a file. Proceeding with Carving operations:$endcolor\n"
		mkdir Output_Data.$ts
		log_file="./Output_Data.$ts/Operation_Log.txt"
		log_operation "Inspecting file: $path"
		log_operation "Generating Binwalk Offset Map of inspected file"
		binwalk $path -e 2> /dev/null
		sleep 0.2
		echo -e "$cyan[+]$endcolor$blue Generating Binwalk Offset Map...$endcolor"
		binwalk $path > Offset_Map.txt
		log_operation "Binwalk Offset Map of inspected file has been generated"
		mv Offset_Map.txt ./Output_Data.$ts/Offset_Map.txt
		echo -e "$green[*] Offset Map file was saved inside the main folder$endcolor\n" 
		sleep 0.2
		if command -v foremost &>/dev/null;
			then
			echo -e "$cyan[+]$endcolor$blue Carving file using Foremost...$endcolor"
			log_operation "Carving inspected file with Foremost"
			foremost -i $path -Q -t all -o Foremost_Output 2>/dev/null
		
			mv Foremost_Output ./Output_Data.$ts/Foremost_Output
			echo -e "$green[*] Foremost carving complete. Data was saved into Foremost_Output inside the main folder$endcolor"
			log_operation "Foremost carving complete; Foremost content: $(tree ./Output_Data.$ts/Foremost_Output/ | tail -1)"
			echo -e "$cyan[+]$endcolor$blue Generating metadata on Foremost output...$endcolor"
			log_operation "Generating Exiftool metadata on Foremost ouput data"
			exiftool -q -r ./Output_Data.$ts/Foremost_Output/ > ./Output_Data.$ts/Foremost_Output_Metadata.txt
			echo -e "$green[*] File metadata was saved into Foremost_Output_Metadata.txt inside the main folder $endcolor\n"
			log_operation "Exiftool metadata generated"
			sleep 0.2
			else
			echo -e "$red[!] Foremost not found! Unable to carve with Foremost$endcolor"
                        log_operation "Carving with Foremost wasn't possible due to it not being installed"

		fi

		if command -v bulk_extractor &>/dev/null;
			then
			echo -e "$cyan[+]$endcolor$blue Carving file using Bulk Extractor...$endcolor"
			log_operation "Carving inspected file with Bulk Extractor"
			bulk_extractor -o Bulk_Output $path &> /dev/null
			sleep 5
				
				if [ -f ./Bulk_Output/packets.pcap ]
					then
					echo -e "$green[!] A packets.pcap file has been located$endcolor"
					echo -e "$cyan[+]$endcolor$yellow The packets' file size is: $endcolor$red$(ls -lh Bulk_Output | grep packets | awk '{print $5}')$endcolor"
					mv ./Bulk_Output/packets.pcap ./Output_Data.$ts/packets.pcap
					echo -e "$cyan[+]$endcolor$yellow Moving packets.pcap into the main folder...$endcolor"
					log_operation "Found .pcap file; moved file to main folder"
					sleep 0.2
					else
					echo -e "$red[!] No packets.pcap file found within carved data$endcolor"
					log_operation "No .pcap file found"
				fi
			mv ./Bulk_Output ./Output_Data.$ts/Bulk_Output
			echo -e "$green[*] Bulk Extractor carving complete. Data was saved into Bulk_Output inside the main folder$endcolor\n"
			log_operation "Bulk Extractor carving complete; Bulk Extractor content: $(tree ./Output_Data.$ts/Bulk_Output/ | tail -1)"
			else
			echo -e "$red[!] Bulk Extractor not found! Unable to carve with Bulk Extractor$endcolor"
			log_operation "Carving with Bulk Extractor wasn't possible due to it not being installed"
		fi

#A strings output folder is created and the script runs strings on the file in order to extract human readable data. It uses a loop function in order to extract the user input data.
		if command -v strings &>/dev/null;
			then
			read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please enter human readable values you wish to extract (use spacebar to seperate the values): $endcolor")" values
			if [ -z "$values" 2>/dev/null ]
				then
                        	echo -e "$red[!] No values were given!$endcolor" ; sleep 0.2
                        	log_operation "No values were given by the user"
				else
				mkdir Strings_Output
				for x in $values
				do
				strings $path | grep -i $x > ./Strings_Output/strings_$x.txt | echo -e "$cyan[+]$endcolor$green $x$endcolor$blue human readable was saved into Strings_Output$endcolor" ; log_operation "Generating strings data based on: $x"
				done
				mv ./Strings_Output ./Output_Data.$ts/Strings_Output
				echo -e "$green[*] Human readable data was saved into Strings_Output inside the main folder$endcolor\n" 
				log_operation "Strings data collection complete; Strings content: $(tree ./Output_Data.$ts/Strings_Output/ | tail -1)"
				sleep 0.2
			fi
			else
			echo -e "$red[!] Strings not found! Unable to extract human readable$endcolor"
			log_operation "Collecting human readable wasn't possible due to Strings not being installed"
		fi
		else
		echo -e "$red[!] No file found in the specified path$endcolor"
		sleep 0.2
		analyze
	fi

#Script attempts to determine the file's profile in order to find out whether or not a .mem file is being used. If a profile is not found - the file is a memory file. If the file is a memory file, the script extracts the profile and displays it on screen. Then, it prompts the user to type in the plugins they would like to use. The script analyzes the file based on the plugins, and saves the data into .html files inside an output folder that is later moved into the main outout folder. If the file is not a memory file, the script prompts the user and continue to the final part. 

if [ -z $voli ];
then

echo -e "$cyan[*]$endcolor$yellow Attempting Volatility analysis on inspected file...$endcolor\n"
log_operation "Checking for memory file for Volatility use"
voli=$(find /home/ -type f -iname "vol" | head -n 1 2>/dev/null)
cp $voli ./vol
sleep 2
	if [ -z "$( ./vol -f $path imageinfo 2> /dev/null | grep -i suggest | grep -i 'No Suggestion' )" ];
                then 
		profile=$( ./vol -f $path imageinfo 2> /dev/null | grep -i suggest | awk '{print $4}' | sed 's/,//g') 
		echo -e "$green[!] The inspected file is a memory file $endcolor$yellow[ File profile: $endcolor$red$profile$endcolor$yellow ]$endcolor\n"
		log_operation "The file is a memory file. File profile: $profile"
		read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please enter the plugins you wish to use for analysis (use spacebar to seperate the plugins): $endcolor")" plugins
		if [ -z "$plugins" 2>/dev/null ]
			then
                        echo -e "$red[!] No plugin inputs given!$endcolor" ; sleep 0.2
                        log_operation "No plugin inputs were given by the user"
						rm vol
						sleep 0.2
			else
			mkdir ./Output_Data.$ts/Volatility_Output
			for x in $plugins
			do
               		./vol -f $path --profile=$profile $x --output=html --output-file=$x.html &> /dev/null | echo -e "$cyan[+]$endcolor$blue Analyzing memeory based on the plugin:$endcolor$green $x $endcolor" ; log_operation "Analyzing memory based on the plugin: $x"
               		mv ./$x.html ./Output_Data.$ts/Volatility_Output/$x.html
			sleep 2

			done
			echo -e "$green[*] Analysis is complete. Data was saved into Volatility_Output inside the main folder$endcolor\n\n"
			log_operation "Volatility analysis complete; Volatility content: $(tree ./Output_Data.$ts/Volatility_Output/ | tail -1)"
			rm vol
			sleep 0.2


		fi
		else echo -e "$red[!] The inspected file is not a memory file. Volatility analysis imossible$endcolor\n\n"
		log_operation "Inspected file is not a memory file. Volatility analysis impossible"
		rm vol
		sleep 0.2
	fi
else
echo -e "$red[!] $endcolor"
log_operation "Memory analysis wasn't possible due to Volatility not being installed"


fi
end_time=$(date +%s)
elapsed_time=$((end_time - start_time))


#The script calculates the elapsed time and saves it into a file. The script then runs the tree command on the output folder in order to catalogue its contents, and adds it to the same file. Once that's done, the file is moved into the output folder, which is then zipped and deleted, leaving only the .zip file. 
echo "Elapsed time: $elapsed_time Seconds" > Table_of_Contents.$ts.txt
tree Output_Data.$ts >> Table_of_Contents.$ts.txt
mv ./Table_of_Contents.$ts.txt ./Output_Data.$ts/Table_of_Contents.$ts

read -p "$(echo -e "\n$cyan[*]$endcolor$green Data carving and gethering complete \n$endcolor$cyan[+]$endcolor$yellow Time elapsed: $endcolor$red$elapsed_time Seconds \n$cyan[+]$endcolor$yellow Foremost content: $endcolor$red$(tree ./Output_Data.$ts/Foremost_Output/ | tail -1)$endcolor\n$cyan[+]$endcolor$yellow Bulk Extractor content: $endcolor$red$(tree ./Output_Data.$ts/Bulk_Output/ | tail -1)$endcolor\n$cyan[+]$endcolor$yellow Strings content: $endcolor$red$(tree ./Output_Data.$ts/Strings_Output/ | tail -1)$endcolor\n$cyan[+]$endcolor$yellow Volatility content: $endcolor$red$(tree ./Output_Data.$ts/Volatility_Output/ | tail -1)$endcolor\n\n$cyan[?]$endcolor$yellow Would you like to zip the output folder? [Y/N] $endcolor")" decision
case $decision in

Y)	log_operation "File inspection complete. Total inspection time: $elapsed_time seconds"
	echo -e "\n$cyan[+]$endcolor$blue Zipping data as$endcolor$green Data_Extractor.$ts$endcolor$blue and cleaning up...$endcolor\n"
	zip -r -q Data_Extractor_Files.$ts Output_Data.$ts
	rm -r Output_Data.$ts
	read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to analyze another file? [Y/N] $endcolor")" answer
        case $answer in
        Y) analyze
        ;;
	y) analyze
	;;
        N)                              echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                                                                exit 1 

	;;
        n)                              echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                                                                exit 1


	;;
        *) echo -e "$red[!] Invalid input!endcolor"
        echo -e "\n$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
                exit 1

        ;;
        esac

;;
y)	log_operation "File inspection complete. Total inspection time: $elapsed_time seconds"
        echo -e "\n$cyan[+]$endcolor$blue Zipping data as$endcolor$green Data_Extractor.$ts$endcolor$blue and cleaning up...$endcolor\n"
        zip -r -q Data_Extractor_Files.$ts Output_Data.$ts
        rm -r Output_Data.$ts
        read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to analyze another file? [Y/N] $endcolor")" answer
        case $answer in
        Y) analyze
        ;;
        y) analyze
        ;;
        N)                              echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                                                                exit 1 

        ;;
        n)                              echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                                                                exit 1


        ;;
        *) echo -e "$red[!] Invalid input!endcolor"
        echo -e "\n$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
                exit 1

        ;;
	esac
;;
N)	log_operation "File inspection complete. Total inspection time: $elapsed_time seconds"
	read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to analyze another file? [Y/N] $endcolor")" answer
       	case $answer in
	Y) analyze
	;;
	y) analyze
	;;

	N) 				echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
										exit 1 
       	;;
	n)                              echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                                                                exit 1

	;;
	*) echo -e "$red[!] Invalid input!endcolor"
        echo -e "\n$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
		exit 1

	;;
	esac
;;
n)	log_operation "File inspection complete. Total inspection time: $elapsed_time seconds"
        read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to analyze another file? [Y/N] $endcolor")" answer
        case $answer in
        Y) analyze
        ;;
        y) analyze
        ;;

        N)                              echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                                                                exit 1 
        ;;
        n)                              echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                                                                exit 1

        ;;
        *) echo -e "$red[!] Invalid input!endcolor"
        echo -e "\n$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
                exit 1

        ;;
        esac
;;
*)	echo -e "$red[!] Invalid input!$endcolor"
	log_operation "File inspection complete. Total inspection time: $elapsed_time seconds"
	echo -e "\n$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
      	echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
		exit 1
;;
esac


}
function log_operation() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> "$log_file"
}



privileges
commence
installation1
installation2
installation3
installation4
installation5
installation6
installation7
test
