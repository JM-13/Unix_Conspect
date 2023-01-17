#!/bin/bash

throw_error () {
    echo -e "\nBAD ARGUMENTS!\n Needs 2 arguments:\n calculate <Njobs> (Njobs == Integer)\n report <outputFile> (outputFile == Filename)\n"; exit 1
}

Allowed_JOBID='^[0-9]+$'

if [[ $# == 2 ]]; then
    if [[ $1 == "calculate" && $2 =~ $Allowed_JOBID ]]; then
    to_do=$2
    JOBID=1
        while [[ $to_do -gt 0 ]]; do
            if ! [[ -f job-$JOBID.out ]]; then
            bash calc.sh $JOBID $((RANDOM%100))
            to_do=$((to_do-1))
            else
            JOBID=$((JOBID+1))
            fi
        done

    elif [[ $1 == "report" ]]; then
    bash summary.sh $2
    fi
else
throw_error
fi
