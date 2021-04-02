#!/bin/bash

./soal3a.sh

TANGGAL="`date +%d-%m-%Y`"
JUMLAH_FOTO=23

rmdir ./$TANGGAL
mkdir ./$TANGGAL

mv Foto.log ./$TANGGAL

for ((num=1; num<=$JUMLAH_FOTO; num=num+1)); do
  namaFile="Koleksi_$num"
  if [ $num -lt 10 ]; then namaFile="Koleksi_0$num"; fi
  if [ ! -f $namaFile ]; then break; fi
  
  mv $namaFile ./$TANGGAL
done