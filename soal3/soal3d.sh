#!/bin/bash
#3d
if [[ -z "$1" ]]; then
password=$(date "+%m%d%Y")
zip -P $password -r Koleksi.zip */
rm -R -- */
fi

# 3e
if [[ $1 == "zip" ]]; 
then
    password=$(date "+%m%d%Y")
    zip -P $password -r Koleksi.zip */

    rm -R -- */
else
    Koleksi=Koleksi.zip
    unzip -P $(date '+%m%d%Y') Koleksi.zip 
    rm Koleksi.zip
fi