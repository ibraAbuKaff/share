#!/bin/bash

# Functions ==============================================

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# display a message in red with a cross by it
# example
# echo echo_fail "No"
function echo_fail {
  # echo first argument in red
  printf "\e[31m✘ ${1}"

  printf "\e[31m Make sure the libraries are installed on your system"

  # reset colours back to normal
  printf "\033\e[0m"

}

# display a message in green with a tick by it
# example
# echo echo_fail "Yes"
function echo_pass {
  # echo first argument in green
  printf "\e[32m✔ ${1}"
  # reset colours back to normal
  printf "\033\e[0m"
}

# echo pass or fail
# example
# echo echo_if 1 "Passed"
# echo echo_if 0 "Failed"
function echo_if {
  if [ $1 == 1 ]; then
    echo_pass $2
  else
    echo_fail $2
  fi
}

# Functions ==============================================



#check if jq and curl has been installed or not
echo "==================================================="
echo "checking jq   if   already installed    $(echo_if $(program_is_installed jq))"
echo "checking curl if   already installed    $(echo_if $(program_is_installed curl))"
echo "==================================================="



###################################################


FILE_PATH=""
DATA=""
EXP=$3


# "d" | "w" | "m" | "y"
DURATION="d"
NUM_DURATION=14

regex='^([0-9]*)(d|m|w|y)$'
if [[ $EXP =~ $regex ]]
then
  DURATION=${BASH_REMATCH[2]}
  NUM_DURATION=${BASH_REMATCH[1]}

fi


URL_TO_BE_SHARED=""
while getopts 'f:d:' OPTION; do
  case "$OPTION" in
    f)
      FILE_PATH="$OPTARG"
      #check if file exists	
       if [ ! -f "$FILE_PATH" ]; then
    		printf "\e[31m✘ Please provide a valid path to the file that you wanna upload and share!"
    		exit 0
	   fi

	   	response=$(curl --silent -F "file=@$FILE_PATH" "https://file.io/?expires=$NUM_DURATION$DURATION" | jq  '.link')

	   	#converting to array
		responseArr=($(echo "$response" | tr '' '\n'))
		URL_TO_BE_SHARED=${responseArr[0]}
      ;;
    d)
      DATA="$OPTARG"
      response=$(curl --silent --data "text=$DATA" "https://file.io/?expires=$NUM_DURATION$DURATION" | jq  '.link')

	   	#converting to array
		responseArr=($(echo "$response" | tr '' '\n'))
		URL_TO_BE_SHARED=${responseArr[0]}

      ;;

    ?)

      echo "script usage: sh $(basename $0) [-f 'PATH_TO_FILE']  [-d 'TEXT_DATA']  '3d|14w|1m|2y'" >&2
      exit 1
      ;;
  esac
done

if [  "${URL_TO_BE_SHARED}" == null ]; then
    printf "\e[31m Ooops, we can't make the file as shareable, make sue the file|data are not empty"
	printf "\033\e[0m"
	exit;
fi

echo "\n "
printf "\e[32m✔ Shareable URL         : $URL_TO_BE_SHARED \n\n";
printf "\e[32m✔ Expires After         : $NUM_DURATION$DURATION [d=day, w=week, m=month, y=year]";
echo "\n "


