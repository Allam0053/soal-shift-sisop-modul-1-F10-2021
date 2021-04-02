#!/bin/bash

TOTAL_FOTO=23

# Operasi matematika
# totalIterasi=1
# totalIterasi=$(($totalIterasi + 1))

# Concatenate string
# namaDepan="Riza"
# namaBelakang="Andhika"
# nama="$namaDepan $namaBelakang"

for ((num=1; num<=23; num=num+1))
do
  namaFile="Koleksi_$num"
  if [ $num -lt 10 ]; then
    namaFile="Koleksi_0$num"
  fi
  curl -Lo./$namaFile -k https://loremflickr.com/320/240/kitten 2>> Foto.log
done

# for ((i=1; i<=23; i=i+1))
# do
# if [ $i -lt 10 ]
# then
# wget -O Koleksi_0$i https://loremflickr.com/320/240/kitten &>> Foto.log
# else
# wget -O Koleksi_$i https://loremflickr.com/320/240/kitten &>> Foto.log
# fi
# done