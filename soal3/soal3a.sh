#!/bin/bash

for ((i=1; i<=23; i=i+1))
do
if [ $i -lt 10 ]
then
wget -O Koleksi_0$i https://loremflickr.com/320/240/kitten &>> Foto.log
else
wget -O Koleksi_$i https://loremflickr.com/320/240/kitten &>> Foto.log
fi
done



