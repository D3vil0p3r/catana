#!/bin/bash

##################################################################################################################
# GREP Classes https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html #
##################################################################################################################

upper='[[:upper:]]'
lower='[[:lower:]]'
digit='[[:digit:]]'
alnum='[[:alnum:]]'
alpha='[[:alpha:]]'
punct='[[:punct:]]'
space='[[:space:]]'

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo
   echo "$(basename "$0") [-h] [-i <wordlist.txt>] [-o <filename.txt>]"
   echo "catana filters your wordlist according to the specified password policy."
   echo
   echo "Syntax: ./catana.sh [-h|i|o]"
   echo
   echo "Options:"
   echo "h     Print this Help."
   echo "i     Input wordlist."
   echo "o     Print to a file."
   echo
   echo "Usage Example:"
   echo "./catana.sh -i rockyou.txt"
   echo
   echo "Reference to character classes: https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html"
}

charset_flt () {
    if [ $2 = "first" ]; then
        filter=$(echo "$1" | grep --text "^$3")
    elif [ $2 = "last" ]; then
        filter=$(echo "$1" | grep --text "$3$")
    elif [ $2 = "rm" ]; then
        filter=$(echo "$1" | grep -v --text "$3")
    fi
    echo "$filter"
}

Menu () {
wl="$1"
echo "$2" > /dev/stderr
PS3="$3"
pos="$4"
options=("Uppercase" "Lowercase" "Digit" "Alphanumeric" "Alphabetic" "Special" "Space" "Specific" "Skip" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Uppercase")
            wl_flt=$(charset_flt "$wl" "$pos" "$upper")
            break
            ;;
        "Lowercase")
            wl_flt=$(charset_flt "$wl" "$pos" "$lower")
            break
            ;;
        "Digit")
            wl_flt=$(charset_flt "$wl" "$pos" "$digit")
            break
            ;;
        "Alphanumeric")
            wl_flt=$(charset_flt "$wl" "$pos" "$alnum")
            break
            ;;
        "Alphabetic")
            wl_flt=$(charset_flt "$wl" "$pos" "$alpha")
            break
            ;;
        "Special")
            wl_flt=$(charset_flt "$wl" "$pos" "$punct")
            break
            ;;
        "Space")
            wl_flt=$(charset_flt "$wl" "$pos" "$space")
            break
            ;;
        "Specific")
            echo "Type the characters or regex:" > /dev/stderr
            read spechar
            wl_flt=$(charset_flt "$wl" "$pos" "$spechar")
            break
            ;;
        "Skip")
            wl_flt=$wl
            break
            ;;
        "Quit")
            return 1
            ;;
        *) echo "Invalid option" > /dev/stderr;;
    esac
done
echo "$wl_flt"
} 

############################################################
# Banner                                                     #
############################################################
#cat banner.txt | gzip | base64
base64 -d <<<"H4sIAAAAAAAAA61RsQ3DMAzbc4VGqUO9d+ofFaCcUaD6qT/0slK25WgqMpQGGNEU5SQmStgpbOi8P4HH63YKuq0T6PP+3ypjf0NWVSO8iOgyu3g6jZdVI6JJe7RH15BgFpl1iTCzeZD0gYIiZee0SkQU/xiDLGYa1phrnaJ91keEueHq4JgGxUU6pSQt9XFKbBohR9qVx+aQTtedPK3y+fFizRqeMNwiMiWEprV9AZQpuGxQAgAA" | gunzip
echo
echo "CATANA - CUT your Wordlist!"
############################################################
############################################################
# Main program                                             #
############################################################
############################################################

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":hi:o:" option; do #When using getopts, putting : after an option character means that it requires an argument (i.e., 'h').
   case "${option}" in
      h) # display Help
         Help >&2
         exit 0
         ;;
      i) # Enter a command
         wl=$OPTARG
         ;;
      o) # Enter an output filename
         out=$OPTARG
         if [ -f ${out} ]; then
            echo "${out} already exist! Do you want to overwrite it?"
            select yn in "Yes" "No"; do
               case $yn in
                  Yes ) rm -rf ${out}; break;;
                  No ) break;;
               esac
            done
         fi
         ;;
      : )
        echo "Missing option argument for -$OPTARG" >&2; exit 0;;
      *  )
        echo "Unimplemented option: -$OPTARG" >&2; exit 0;;
     \?) # Invalid option
         echo "Error: Invalid option" >&2
         ;;
   esac
done
echo
# mandatory arguments
if [ ! "$wl" ]; then
  Help >&2
  echo "catana: error: missing a mandatory option (-i). Use -h for help"
  exit 0
fi


echo "Wordlist: $wl"
echo
#Set variables
echo "Loading Wordlist..."
flt_wl=$(cat $wl)
echo
echo "Note: remember to use escape characters against regex special characters (like $ or ?)"
echo
echo "Gimme some information about the Password Policy"
echo

quest="What is the first character?"
prmpt="First character:"
pos="first"
flt_wl=$(Menu "$flt_wl" "$quest" "$prmpt" "$pos")
echo

quest="What is the last character?"
prmpt="Last character:"
pos="last"
flt_wl=$(Menu "$flt_wl" "$quest" "$prmpt" "$pos")
echo

quest="Do you wish some characters to be removed?"
prmpt="Chars to remove:"
pos="rm"
flt_wl=$(Menu "$flt_wl" "$quest" "$prmpt" "$pos")
echo

echo "Do you wish some characters to be present?"
PS3='Answer:'
select yn in "Yes" "No"; do
   case $yn in
      Yes ) echo "Type the characters or regex [i.e., @|\\$|#|\?]:"; read spechar; flt_wl=$(echo "$flt_wl" | grep -E --text "$spechar"); break;;
      No ) break;;
   esac
done
echo

echo "Specify the minimum length:"
read min
echo "Specify the maximum length:"
read max
echo

flt_wl=$(echo "$flt_wl" | grep -E '^.{'$min','$max'}$')

if [ ! "$out" ]; then
    echo "$flt_wl"
    echo
else
    echo "$flt_wl" > $out
    echo "Result correctly stored in ${out} file"
    echo
fi
