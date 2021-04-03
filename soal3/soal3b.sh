#!/bin/bash

./soal3a.sh

# Value dari $NAMA_FOLDER adalah String tanggal dengan format (DD-MM-YYYY)
NAMA_FOLDER="`date +%d-%m-%Y`"
JUMLAH_FOTO=23

# Buat folder bernama $NAMA_FOLDER (jika belum ada folder-nya)
if [ ! -d "$NAMA_FOLDER" ]; then mkdir ./$NAMA_FOLDER; fi;

# Pindahkan Foto.log ke folder bernama $NAMA_FOLDER
mv Foto.log ./$NAMA_FOLDER

# Pindahkan foto-foto terdownload ke folder $NAMA_FOLDER
for ((num=1; num<=$JUMLAH_FOTO; num=num+1)); do
  namaFile="Koleksi_$num"
  if [ $num -lt 10 ]; then namaFile="Koleksi_0$num"; fi
  if [ ! -f $namaFile ]; then break; fi
  
  mv $namaFile ./$NAMA_FOLDER
done