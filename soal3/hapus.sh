#!/bin/bash

rm Foto.log

for ((num=1; num<=23; num=num+1))
do
  namaFile="Koleksi_$num"
  if [ $num -lt 10 ]; then
    namaFile="Koleksi_0$num"
  fi
  rm $namaFile
done