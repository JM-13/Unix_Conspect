#!/bin/bash

all_args=($@)
arit_args=()
for i in `seq 0 $#` ; do

    if [ ${#arit_args[@]} -lt 3 ] && ! [ $i -eq $# ]; then
    arit_args+=(${all_args[$i]})
    continue

    else
    arg_1=(`bash aritmetika.sh ${arit_args[@]}`)
    exit_code=$?
        if ! [ $exit_code == 0 ]; then
        echo ${arg_1[@]}
        exit $exit_code
        elif [ ${#arit_args[@]} -eq 0 ]; then
        echo "Needs arguments !"; exit 1
        fi
    arit_args=(${arg_1[-1]} ${all_args[$i]})
    answer=${arg_1[-1]}
    echo "${arg_1[@]}"
    continue
    fi
done
#echo "ats=$answer"
