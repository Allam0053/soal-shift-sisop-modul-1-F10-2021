#!/bin/bash

tanggal="`date`"

for ((i=1; i<=23; i=i+1))
do
if [ $i -lt 10 ]
then
wget -P ~/"$tanggal" -O Koleksi_0${i} https://loremflickr.com/320/240/kitten &>> ~/"$tanggal"/Foto.log
else
wget -P ~/"$tanggal" -O Koleksi_${i} https://loremflickr.com/320/240/kitten &>> ~/"$tanggal"/Foto.log
fi
done
