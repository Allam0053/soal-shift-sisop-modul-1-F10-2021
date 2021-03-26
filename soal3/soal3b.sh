#!/bin/bash

tanggal="`date +%d-%m-%Y`"

for ((i=1; i<=23; i=i+1))
do
if [ $i -lt 10 ]
then
mv Koleksi_0${i} "$tanggal"
else
mv Koleksi_${i} "$tanggal"
fi
done
mv Foto.log "$tanggal"
