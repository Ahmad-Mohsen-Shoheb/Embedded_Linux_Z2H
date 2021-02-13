#!/bin/bash
#if the calling of this bash has no fed arguments, return options

clear
ERRORFLAG=0
###########################################################################################################################################################
if [ "$#" = 0 ]; then # if number of arguments given to the bash script  is = 0
echo "Options are:"
echo "------------"
printf -- "-i: insert new contact \n-v:view all contacts"
printf -- "\n-s:search by name\n-e:delete all"
printf "\n-d:delete only one contact by name\n" 
fi

localswitch=$1 # this will switch on value of first parameter given to the bash and ignore rest of parameters if exists.
#switch on first input parameter
case $localswitch in
"-i")
	read -p " enter name: " name_entry
	if grep -i "$name_entry" ./phonebookDB.txt > /dev/null ; then #-i, --ignore- upper lower case desctintion,,, q quiet ,,, x line match 
				if [ ${#name_entry} -le 4 ]; then 
					echo "Invalid name, please try longer name."
					exit 1
				else
					echo "Error, name is already stored in the phonebook, pick another name."
					exit 1
				fi				
	fi
			
	read -p " enter phone: " phone_entry
	if [ "$name_entry" == "" ] || [ "$phone_entry" == "" ] ; then # if the user has entered nothing for the name  ###--->  || [ ${#name_entry} > 50 ]
		echo "Not enough data was entered, Please try again"; exit 1;
	else
		
		if grep -P "^01[0-9]{9}$" ./phonebookDB.txt > /dev/null; then # if the phone is correct
			#check on name if exist before?
			#put limitation on name '50' char, put limitation on each name '10' chars.
		
			if grep -Eix "$phone_entry" ./phonebookDB.txt  > /dev/null ; then	
				echo "Error, this phonenumber already exists with another name.";	exit 1;	fi
				
			#if [ ${#phone_entry} != 11 ]; then echo ""; exit 1; fi			
		else echo "Error, invalid phone number. phone number must consist of 11 digits start with '01'"; exit 1; fi
	fi
##########################################################
	if [ $ERRORFLAG == 0 ]; then
	#if all is well, add it to the file
	#check if the file actually exists
		echo $name_entry >> ./phonebookDB.txt
		echo $phone_entry >> ./phonebookDB.txt
		echo "Data was inserted sucessfully, thank you"
	else 
		echo "Invalid data entered, Please try again"
	fi

	;;
###########################################################################################################################################################
"-v")
	echo "viewing phonebook data: "
	echo "------------------------"
	#sed -n '101,$p' phonebook
	cat ./phonebookDB.txt
	;;

"-s")
	read -p " enter name: " name_entry
	if grep -i "$name_entry" ./phonebookDB.txt  > /dev/null ; then 
	echo " ---- name & phone number ---- "
	printf "     "
	grep -i "$name_entry" ./phonebookDB.txt | tr ";" ">"
	else echo "name was not found" ; fi
	
	#check on name exists ?
	# display name and phone number of it if exist
	;;

"-e")
	echo "Deleting the phonebook database"
	#awk '/Ahmed Taha/{print NR}' phonebookDB.txt 2> hhh
	echo "" > ./phonebookDB.txt
	;;

"-d")
	echo "enter name to delete it"
	#check on name exists ?
	#delete the contact and prompt if user want to view after deleting
	;;
*)
	echo "unkown choice, please try again";;
esac
#
#
#
#read -p " Enter Something " entry
#echo "you have entered"  $entry
exit 0



#------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------#
#-------------------------------Phonebook database ----------------------------------#
#------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------*#
#
# i want to loop on each line
# check on the name if matches with th entry
# take a line
# execute some comparison
# go to the next line 