#!/bin/bash

script=./aritmetika.sh

testit() {
    __msg=$1; __expect=$2; __res=$3; shift 3
    printf '_%.0s' {1..50}
    echo -e "\n\nTikrinu atvejį $__msg ($@)"
    res=$(bash $script $@)
    echo -e "\nTikrinimas atliktas (baigties kodas=$?), laukta: ${__expect}"
    if [ ${__expect} == "ok" ] ; then echo "Lauktas ats=${__res}"; fi
    echo -e "Got res <${res}>"
    #ans=($res)
    #echo "ans[2]=${ans[4]}"
    printf '_%.0s' {1..50}
    printf '\n'
}


testit 'be argumentų' bad
testit 'arg' bad x   a
testit 'arg' ok 0    0
testit 'arg' ok 1    1
testit 'arg' ok -1   -1
testit 'arg' ok 1    +1
testit 'arg' bad x   1+1
testit 'arg' bad x   1 + a1
testit 'arg' bad x   1 +
testit 'arg' ok 1    -1 + +2
testit 'arg' ok -3   -1 + -2
#exit
testit 'arg' ok 4   2 + 2
testit 'arg' ok 1   2 / 2
testit 'arg' ok 1   5 rem 2
testit 'arg' ok 4   2 x 2
testit 'arg' ok 3   5 - 2
testit 'arg' bad x  2 x 2 + 3
testit 'arg' bad x  2 a 2
