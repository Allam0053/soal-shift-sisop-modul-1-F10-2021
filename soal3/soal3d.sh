#!/bin/bash
#3d
password=$(date "+%m%d%Y")
zip -P $password -r Koleksi.zip */
rm -R -- */

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