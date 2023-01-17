#!/bin/bash

if [[ $2 -lt 50 ]]; then
echo "RUN STATUS: INPUT ERROR" > "job-$1.out"

elif [[ $2 -gt 60 ]]; then
echo "RUN STATUS: DONE" > "job-$1.out"

else
echo "RUN STATUS: ERROR $2" > "job-$1.out"
fi
