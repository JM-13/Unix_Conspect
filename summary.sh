#!/bin/bash

Jobs_to_check=(job-*.out)

INPUT_ERROR=0
DONE=0
ERROR=()

for job in ${Jobs_to_check[*]}; do
    job_info=`cat $job`
    case $job_info in
    'RUN STATUS: INPUT ERROR') let INPUT_ERROR+=1;;
    'RUN STATUS: DONE') let DONE+=1;;
    *) ERROR+=("$job_info");;
    esac
done
echo "" > $1
echo "Analyzed ${#Jobs_to_check[@]} Jobs: " >> $1
echo "RUN STATUS: INPUT ERROR = $INPUT_ERROR" >> $1
echo "RUN STATUS: DONE = $DONE" >> $1

annoying=`(IFS=$'\n';sort <<< "${ERROR[*]}") | uniq -c`
track_5=1
for special in ${annoying[*]}; do
    if ! [[ $track_5 -eq 5 ]]; then
        if [[ $track_5 -eq 1 ]]; then
        uniqe_error_number=$special
        let track_5+=1
        else
        uniqe_error+="$special "
        let track_5+=1
        fi
    elif [[ $track_5 -eq 5 ]]; then
    uniqe_error+="$special "
    echo "$uniqe_error= $uniqe_error_number" >> $1
    track_5=1
    uniqe_error=""
    fi
done
