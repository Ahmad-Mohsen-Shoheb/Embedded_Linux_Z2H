#!/bin/bash
#---------------------------- Phonebook, version 2.5 ----------------------------------------
# ADDED FEATURES IN THIS CODE
#checking on the file that contain the data base if it does exist
#organizing the code into functions
#if the calling of this bash has no fed arguments, return options
#adding the option to create new database file in case file does not exist. 
#delete user is now possible 
#----------------------------
# old features
# searching by name is possible even if we search on 'Ahmed' while name is stored 'ahmed'
# search by name is DONE
#----------------------------
# Still Missing features
# Deleting a specific name in the database.
# generating error in case the user enters a number in the name.
# Taking more than one phone number for same user
# being more powerful in showing the name and phone in more professional way in the search method.
# Adding the phonebook database inside the bash script (problem only with view & delete database features)
# what else after creating new file if not exist? I need to make the file name does not exist


# delete bug #1 (case sensitive && matches word, not while name) 
# delete bug #2 if two users have same title in their name, it will delete both
##############################################################
export FILE=phonebookDB.txt
clear
ERRORFLAG=0
export NAME_ENTRY
export PHONE_ENTRY
choice=0
new_file_name=0
##############################################################
function fun3 {
if [ -f "$FILE" ]; then
    echo "$FILE exists." > /dev/null
	else
	echo "The phonebook database does not exist, would you like to create one?"
	read -p "(Y/N) ?" choice
case $choice in
Y)
	read -p " enter name: " new_file_name
	touch "$new_file_name"
	FILE=$new_file_name
	;;
"N")
	exit 0
	;;
"*")
	echo "no correct option was selected. exiting..."
	exit 1 
	;;
esac
fi
}
###########################################################################################################################################################
if [ "$#" = 0 ]; then # if number of arguments given to the bash script  is = 0
echo "Options are:"
echo "------------"
printf -- "-i: insert new contact \n-v:view all contacts"
printf -- "\n-s:search by name\n-e:delete all"
printf "\n-d:delete only one contact by name\n" 
fi
###################################################################################
function fun1 {
	fun3
	if grep -i "$NAME_ENTRY" "$FILE" > /dev/null ; then #-i, --ignore- upper lower case desctintion,,, q quiet ,,, x line match 
				#
				#
				if [ ${#NAME_ENTRY} -le 4 ]; then 
					echo "Invalid name, please try longer name."
					exit 1
				else
					echo "Error, name is already stored in the phonebook, pick another name."
					exit 1
				fi
				#
				#
	fi
}
###################################################################################
function fun2 {
	if [ "$NAME_ENTRY" == "" ] || [ "$PHONE_ENTRY" == "" ] ; then # if the user has entered nothing for the name  ###--->  || [ ${#name_entry} > 50 ]
		echo "Not enough data was entered, Please try again"; exit 1;
	else
		#
		#
		#"^01[0-9]{9}$"  --> this didnt work
		if grep  "^01[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" <<< $PHONE_ENTRY > /dev/null; then # if the phone is correct (regex shape)
			#check on name if exist before?
			#put limitation on name '50' char, put limitation on each name '10' chars.
		#if [ ${#phone_entry} != 11 ]; then echo ""; exit 1; fi		
			echo ""
		else echo "Error, invalid phone number. phone number must consist of 11 digits start with '01'"; exit 1; fi
		#
		#
		#
	fi

 	if grep -Eix "$PHONE_ENTRY" "$FILE"  > /dev/null ; then #search on the phone number inside the phoneDB	
	echo "Error, this phonenumber already exists with another name.";	exit 1;	fi
				
	#echo "end of function2"
}
###################################################################################
localswitch=$1 # this will switch on value of first parameter given to the bash and ignore rest of parameters if exists.
#switch on first input parameter
case $localswitch in
"-i")
	read -p " enter name: " NAME_ENTRY 
	read -p " enter phone: " PHONE_ENTRY
	fun1
	fun2
	echo "$NAME_ENTRY;$PHONE_ENTRY" >> "$FILE"
	echo "Data was inserted sucessfully, thank you"
	;;
	
"-v")
		echo "viewing phonebook data: "
		echo "------------------------"
		fun3
		cat "$FILE"
	;;

"-s")
	#check on name exists ? ---> display name and phone number of it if exist
	read -p " enter name: " NAME_ENTRY
	if grep -i "$NAME_ENTRY" "$FILE"  > /dev/null ; then 
	echo " ---- name & phone number ---- "
	printf "     "
	grep -i "$NAME_ENTRY" "$FILE" | tr ";" ">"
	else echo "name was not found0"
	     echo "exiting the phonebook bash" ; fi
	
	;;

"-e")
	echo "Deleting the phonebook database"
	echo "" > "$FILE"
	;;

"-d")
	#check on name exists ? ---> delete the contact and prompt if user want to view after deleting
	echo "enter name to delete it"
	read -p " enter name: " NAME_ENTRY
	if grep -i "$NAME_ENTRY" "$FILE"  > /dev/null ; then  # if the file do exist in the phonebook
	#a regex '$' and '^' is added beside the variable name to prevent deleting any user but only one specific user.
		sed "/^$NAME_ENTRY;/d" phonebookDB.txt > phonebookDB.txt # print the result of 'sed' to the same file to apply changes made by 'sed' to the file
		#sed -n'/^$/d' "$FILE"     #to delete empty lines in a file
		echo "name was deleted successfully"
	else
		echo "name was not found"
	fi
	# sed command is case sensitive and I dont know how not to make it like that
	# also how to check if sed found the line?
	;;
*)
	echo "unkown choice, please try again";;
esac
######
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
-----------------------------------------
Ahmed Ali elbanna;01234458972
Ahmed Aly;01245436789
omar;01234565438
ahmed mohsen;0123558
Ahmed Taha;0100556665
