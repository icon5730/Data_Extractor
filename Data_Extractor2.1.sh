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
                echo -e "$redWARNING!!! \nThis script must run with root privileges. \nPlease restart the script under root. \nTerminating script operations...$endcolor"
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
                            echo -e "$red[!] Figlet is not installed$endcolor"
                            echo -e "$yellow[+] Installing Figlet:$endcolor"
                            sudo apt install figlet &> /dev/null
                                echo -e "$green[*] Figlet is installed$endcolor"
                                sleep 0.2
                        else
                            echo -e "$green[*] Figlet is already installed$endcolor"
                                sleep 0.2
fi
}

#Same concept as the previous function, only for Foremost.
function installation2(){

if ! command -v foremost &> /dev/null ;then
                            echo -e "$red[!] Foremost is not installed$endcolor"
                            echo -e "$yellow[+] Installing Foremost:$endcolor"
                            sudo apt install foremost &> /dev/null
                                echo -e "$green[*] Foremost is installed$endcolor"
                                sleep 0.2
                        else
                            echo -e "$green[*] Foremost is already installed$endcolor"
                                sleep 0.2
fi
}

#Same concept as the previous installation functions, only for Bulk Extractor.
function installation3(){
if ! command -v bulk_extractor &> /dev/null ;then
                            echo -e "$red[!] Bulk Extractor is not installed$endcolor"
                            echo -e "$yellow[+] Installing Bulk Extractor:$endcolor"
                            				git clone --recurse-submodules https://github.com/simsong/bulk_extractor.git &> /dev/null
							apt-get install libre2-dev &> /dev/null
							cd bulk_extractor 
							./bootstrap.sh &> /dev/null
							./configure &> /dev/null
							make &> /dev/null
							make install &> /dev/null
							cd ..
                                echo -e "$green[*] Bulk Extractor is installed$endcolor"
                                sleep 0.2
                        else
                            echo -e "$green[*] Bulk Extractor is already installed$endcolor"
                                sleep 0.2
fi
}

#Same concept as the previous installation functions.
function installation4(){
if ! command -v strings &> /dev/null ;then
                            echo -e "$red[!] Strings is not installed$endcolor"
                            echo -e "$yellow[+] Installing Strings:$endcolor"
                            sudo apt install figlet &> /dev/null
                                echo -e "$green[*] Strings is installed$endcolor"
                                sleep 0.2
                        else    
                            echo -e "$green[*] Strings is already installed$endcolor"
                                sleep 0.2
fi
}

#This function tries to locate the Volatility executable, now named vol. If it fails to locate the file, it dnowloads Volatility, unzips it, and renames the exacutable to vol. 
function installation5(){
voli=$(locate -b -l 1 volatility_2.5.linux.standalone)
if [[ ! $voli ]]; then
        echo -e "$red[!] Volatility is not installed$endcolor"
        echo -e "$yellow[+] Installing Volatility:$endcolor"
        wget http://downloads.volatilityfoundation.org/releases/2.5/volatility_2.5.linux.standalone.zip &> /dev/null
	unzip volatility_2.5.linux.standalone.zip &> /dev/null
	mv ./volatility_2.5.linux.standalone/volatility_2.5_linux_x64 ./volatility_2.5.linux.standalone/vol &> /dev/null
        echo -e "$green[*] Volatility is installed$endcolor"
        sleep 0.2
else
        echo -e "$green[*] Volatility is already installed$endcolor"
        sleep 0.2
fi
}
#Last installation function. Same as the first four.
function installation6(){
if ! command -v tree &> /dev/null ;then
                            echo -e "$red[!] Tree is not installed$endcolor"
                            echo -e "$yellow[+] Installing Tree:$endcolor"
                            sudo apt install tree &> /dev/null
                                echo -e "$green[*] Tree is installed$endcolor"
                                sleep 0.2
                        else
                            echo -e "$green[*] Tree is already installed$endcolor"
                                sleep 0.2
fi
}

#This is just a text function to let the user know everything is installed, and to feature the script name: Data Extractor.
function text(){

echo -e "$yellow*******************************************************************************$endcolor"
echo -e "$yellow***********EVERYTHING IS GOOD TO GO, PROCEEDING TO SCRIPT OPERATIONS:**********$endcolor"
echo -e "$yellow*******************************************************************************$endcolor"
echo -e "$yellow*******************************************************************************$endcolor"

printf $blue
figlet "Data Extractor 2.1"
printf $endcolor
}


#The main function of the script. Everything was put into one function in order to allow looping it once the script is complete.
function analyze (){
#Timestamp (ts) is set in order to timestamp the output folder, and later the zip file.
ts=$(date +%a_%b.%d_%Y_%H:%M:%S)

read -p "[?] Please specify the path of the file you wish to inspect: " path
#Using the date command in order to later calculate the elapsed time.
start_time=$(date +%s)
#This part of the function checks if a file exists in the path provided by the user. If a file exists, it alerts the user, creates an output folder and starts running Foremost and Bulk Extractor on the file. Folders are created and moved inside the output folder in order to store the output data. If a file doesn't exist, the user is alerted and the script terminates.
	if [ -f $path ];
		then
		echo -e "$green[!] Path contains a file. Proceeding with Carving operations:$endcolor\n"
		mkdir Output_Data.$ts
		binwalk $path -e 2> /dev/null
		sleep 0.2
		echo -e "$cyan[+] Generating Binwalk Offset Map...$endcolor"
		binwalk $path > Offset_Map.txt
		mv Offset_Map.txt ./Output_Data.$ts/Offset_Map.txt
		echo -e "$green[*] Offset Map file was saved inside the main folder$endcolor\n" 
		sleep 0.2
		echo -e "$cyan[+] Carving file using Foremost...$endcolor"
		foremost -i $path -Q -t all -o Foremost_Output
		
		mv Foremost_Output ./Output_Data.$ts/Foremost_Output
		echo -e "$green[*] Foremost carving complete. Data was saved into Foremost_Output inside the main folder$endcolor\n"
		echo -e "$cyan[+] Carving file using Bulk Extractor...$endcolor"
		bulk_extractor -o Bulk_Output $path &> /dev/null
		sleep 5
			if
				[ -f ./Bulk_Output/packets.pcap ]
					then
					echo -e "$green[!] A packets.pcap file has been located$endcolor"
					echo -e "$cyan[+] The packets' file size is: $(ls -lh Bulk_Output | grep packets | awk '{print $5}')$endcolor"
					mv ./Bulk_Output/packets.pcap ./Output_Data.$ts/packets.pcap
					echo -e "$cyan[+} Moving packets.pcap into the main folder...$endcolor"
					sleep 0.2
					else
					echo -e "$red[!] No packets.pcap file found within carved data$endcolor"
			fi
		mv ./Bulk_Output ./Output_Data.$ts/Bulk_Output
		echo -e "$green[*] Bulk Extractor carving complete. Data was Saved into Bulk_Output inside the main folder$endcolor\n"

#A strings output folder is created and the script runs strings on the file in order to extract human readable data. It uses a loop function in order to extract the user input data.
		mkdir Strings_Output
		read -p "[?] Please enter human readable values you wish to extract (use spacebar to seperate the values): " values
		for x in $values
		do
		strings $path | grep -i $x > ./Strings_Output/strings_$x.txt | echo -e "$cyan[+] $x human readlable was saved into Strings_Output$endcolor"
		done
		mv ./Strings_Output ./Output_Data.$ts/Strings_Output
		echo -e "$green[*] Human readable data was saved into Strings_Output inside the main folder$endcolor\n" 
		sleep 0.2
		

		else
		echo -e "$red[!] No file found in the specified path. Please restart the script and input a correct path$endcolor"
		exit 1
	fi

#Script attemts to determine the file's profile in order to find out whether or not a .mem file is being used. If a profile is not found - the file is a memory file. If the file is a memory file, the script extracts the profile and displays it on screen. Then, it prompts the user to type in the plugins they would like to use. The script analyzes the file based on the plugins, and saves the data into .html files inside an output folder that is later moved into the main outout folder. If the file is not a memory file, the script prompts the user and continue to the final part. 
echo -e "$yellow[*] Attempting Volatility analysis on inspected file...$endcolor\n"
cp $voli/vol ./vol
sleep 2
	if [ -z "$( ./vol -f $path imageinfo 2> /dev/null | grep -i suggest | grep -i 'No Suggestion' )" ];
                then 
		profile=$( ./vol -f $path imageinfo 2> /dev/null | grep -i suggest | awk '{print $4}' | sed 's/,//g') 
		echo -e "$green[!] The inspected file is a memory file [ File profile: $profile ]$endcolor\n"
		

		read -p "[?] Please enter the plugins you wish to use for analysis (use spacebar to seperate the plugins): " plugins
		mkdir ./Output_Data.$ts/Volatility_Output
		for x in $plugins
		do
               	./vol -f $path --profile=$profile $x --output=html --output-file=$x.html &> /dev/null | echo -e "$cyan[+] Analyzing memeory based on the plugin: $x $endcolor"
               	mv ./$x.html ./Output_Data.$ts/Volatility_Output/$x.html
		sleep 2

		done
		echo -e "$green[*] Analysis is complete. Data was saved into Volatility_Output inside the main folder$endcolor\n\n"
		rm vol
		sleep 0.2

		else echo -e "$red[!] The inspected file is not a memory file. Volatility analysis imossible$endcolor\n\n"
		rm vol
		sleep 0.2
	fi



end_time=$(date +%s)
elapsed_time=$((end_time - start_time))


#The script calculates the elapsed time and saves it into a file. The script then runs the tree command on the output folder in order to catalogue its contents, and adds it to the same file. Once that's done, the file is moved into the output folder, which is then zipped and deleted, leaving only the .zip file. 
echo "Elapsed time: $elapsed_time Seconds" > Table_of_Contents.$ts.txt
tree Output_Data.$ts >> Table_of_Contents.$ts.txt
mv ./Table_of_Contents.$ts.txt ./Output_Data.$ts/Table_of_Contents.$ts

read -p "[?] Data carving and gethering complete. Would you like to zip the output? [Y/N]: " decision
case $decision in

Y)	echo -e "\n$cyan[+] Zipping data as Data_Extractor.$ts and cleaning up...$endcolor\n"
	zip -r -q Data_Extractor_Files.$ts Output_Data.$ts
	rm -r Output_Data.$ts
	read -p "[?] Would you like to analyze another file? [Y/N] " answer
       	if [ $answer == Y ]; then analyze
                               else     echo -e "\n$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        echo -e "$yellow*******************************************************************************$endcolor"
                                        exit 1 
       	fi
;;

N)	read -p "[?] Would you like to analyze another file? [Y/N] " answer
       	case $answer in
	Y) analyze
	;;

	N) 				echo -e "\n$yellow*******************************************************************************$endcolor"
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
	echo -e "\n$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
      	echo -e "$yellow*************************ANALYSIS COMPLETE! EXITING...*************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        echo -e "$yellow*******************************************************************************$endcolor"
        exit 1
;;
esac


}


privileges
commence
installation1
installation2
installation3
installation4
installation5
installation6
text
analyze
