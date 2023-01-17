#!/bin/bash

Integers='^[+-]?[0-9]+$'

do_equation () {
    case $2 in
    +) let answer=$1+$3 ;;

    -) let answer=$1-$3 ;;

    x) let answer=$1*$3 ;;

    /) let answer=$1/$3 ;;

    rem) let answer=$1%$3 ;;

    *) echo "$2 operand not supported"; exit 1 ;;
    esac

    echo $1 $2 $3 = $answer
}

if [[ $# -eq 0 ]]; then
echo $@

elif [[ $# -eq 1 ]]; then
    if [[ $1 =~ $Integers ]]; then
    echo $1 = $1

    else
    echo "$1 is not an integer"; exit 1
    fi

elif [[ $# -eq 2 ]]; then
    case $2 in
    +)  echo "Nothing to do $2 with"; exit 1;;

    -)  echo "Nothing to do $2 with"; exit 1;;

    x)  echo "Nothing to do $2 with"; exit 1;;

    /)  echo "Nothing to do $2 with"; exit 1;;

    rem)echo "Nothing to do $2 with"; exit 1;;

    *) echo "$2 operand not supported"; exit 1 ;;
    esac

elif [[ $# -eq 3 ]]; then

    if ! [[ $1 =~ $Integers ]]; then
    echo "$1 is not an integer"; exit 1

    elif ! [[ $3 =~ $Integers ]]; then
    echo "$3 is not an integer"; exit 1

    elif [[ $1 =~ $Integers ]] && [[ $3 =~ $Integers ]]; then
        if [[ $3 == 0 ]] && [[ $2 == / || $2 == rem ]]; then
        echo "Devision by 0 not permited"; exit 1
        fi
    do_equation $@
    fi

elif [[ $# -gt 3 ]]; then
echo "Too many arguments. Takes 3 given $#"; exit 1
fi
