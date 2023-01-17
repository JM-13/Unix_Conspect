#!/bin/bash

# check whether the argument is an integer number
checkIntNum()
{
    if [ ${#1} -eq 0 ] ; then return 254; fi
    if [ ${1:0:1} == '-' ] || [ ${1:0:1} == '+' ] ; then
	if [ ${#1} -eq 1 ] ; then return 255; fi
	_a=${1:1:${#1}}
    else
	_a=$1
    fi
    if [[ ${_a} =~ [^[:digit:]] ]] ; then
	return 255
    fi
    return 0
}

ERR_BAD_INPUT=255
ERR_WRONG_TERM_COUNT=253
ERR_BAD_OPERATOR=252
NO_ERR=0

# printFormat: 1 - print input sequence, 2 - print operation sequence, otherwise - print nothing
printFormat=1

# set initial value
arithmRES=99.99

# check that we have 1 or 3 terms
if [ $# -ne 1 ] && [ $# -ne 3 ] ; then
    exit ${ERR_WRONG_TERM_COUNT}
fi
    
# check that the first term is a number
checkIntNum $1
if [ $? -ne 0 ] ; then exit ${ERR_BAD_INPUT}; fi
    
## check that we have <number><operation><number>

# An allowed situation is one term
if [ ${#3} -eq 0 ] ; then
    echo "$1 = $1"
    arithmRES=$1
    exit ${NO_ERR}
fi

# check that the last term is an integer number
checkIntNum $3
if [ $? -ne 0 ] ; then exit ${ERR_BAD_INPUT}; fi

## Identify the correct operator
rop=$2
case $2 in
    +|-|/) ;;
    x) rop='*' ;;
    rem) rop='%' ;;
    *)  # bad operator
	exit ${ERR_BAD_OPERATOR}
esac

## Perform the arithmetics
arithmRES=$(( $1 $rop $3 ))

## Print the message
case ${printFormat} in
    1) echo "$1 $2 $3 = $arithmRES" ;;
    2) echo "$1 $rop $3 = $arithmRES" ;;
esac

exit ${ERR_NO_ERR}
