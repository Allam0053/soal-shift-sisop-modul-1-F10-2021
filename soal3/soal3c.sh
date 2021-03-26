#!/bin/bash

tanggal=`date +%s` #penanggalans sejak 1 Januari 1970
danggal=`date +%d-%m-%Y`
let hari=$tanggal/86400

if [ $(( $hari % 2)) -eq 0 ]
then
wget -P ~/Kucing_"$danggal" https://loremflickr.com/320/240/kitten
else
wget -P ~/Kelinci_"$danggal" https://loremflickr.com/320/240/bunny
fi
