#!/bin/bash
MODE=$1
INPUT=$2
OUT=$INPUT.temp
function _inv_usage
{
    echo "Invalid Usage of $0 : "
    echo '$1: Mode e, encrypt, d, decrypt, r and read (Mandatory).'
    echo '$2: The Path of the File to process (Mandatory).'
    exit 1
}
main
{
if ! which openssl > /dev/null; then
    echo "Please install openssl to continue Encrypt/Decrypt."
    exit 1
fi
if [ "x$INPUT" == "x"  ]; then
    echo "Please Specify Input File."
    _inv_usage
fi


if [ "x$MODE" == "xe" -o  "x$MODE" == "xencrypt"  ]; then
    echo "Encrypting File"
    openssl aes-256-cbc -a -salt -in $INPUT -out $OUT
    rm -rfP $INPUT
    mv -f $OUT $INPUT
    exitCode="$?"
    exit $exitCode
fi
if [ "x$MODE" == "xr" -o  "x$MODE" == "xread"  ]; then
    echo "Reading File"
    openssl aes-256-cbc -d -a -in $INPUT
    exitCode="$?"
    exit $exitCode
fi
if [ "x$MODE" == "xd" -o  "x$MODE" == "xdecrypt"  ]; then
    echo "Decrypting File"
    openssl aes-256-cbc -d -a -in $INPUT -out $OUT
    rm -rfP $INPUT
    mv -f $OUT $INPUT
    exitCode="$?"
    exit $exitCode
else
    _inv_usage
fi
}
