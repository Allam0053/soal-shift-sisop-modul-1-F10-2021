#!/bin/bash

TOTAL_FOTO=23

formatNamaFile() {
  nomorDihapus=$1
  for ((i=$nomorDihapus; i<$TOTAL_FOTO; i=i+1)); do
    lebihSatu=$(($i+1))

    namaBaru="Koleksi_$i"
    namaLama="Koleksi_$lebihSatu"

    if [ $i -lt 10 ]; then namaBaru="Koleksi_0$i"; fi
    if [ $lebihSatu -lt 10 ]; then namaLama="Koleksi_0$lebihSatu"; fi

    mv $namaLama $namaBaru
  done
}

for ((num=1; num<=$TOTAL_FOTO; num=num+1)); do
  namaFile="Koleksi_$num"
  if [ $num -lt 10 ]; then namaFile="Koleksi_0$num"; fi
  curl -Lo ./$namaFile -k https://loremflickr.com/320/240/kitten 2>> Foto.log
done

sama=0
for ((i=1; i<=$TOTAL_FOTO; i=i+1)); do
  for ((j=1; j<=$TOTAL_FOTO; j=j+1)); do
    file1="Koleksi_$i"
    file2="Koleksi_$j"

    if [ $i -lt 10 ]; then file1="Koleksi_0$i"; fi
    if [ $j -lt 10 ]; then file1="Koleksi_0$j"; fi
    if [ $i == $j -o ! -f $file1 -o ! -f $file2 ]; then continue; fi
    
    fileSama=$(cmp $file1 $file2)
    if [ -z $fileSama ]; then 
      sama=$(($sama+1))
      rm $file2
      formatNamaFile $j
    fi
  done
done

# echo "ada $sama file yang sama"

# Operasi matematika
# totalIterasi=1
# totalIterasi=$(($totalIterasi + 1))

# Concatenate string
# namaDepan="Riza"
# namaBelakang="Andhika"
# nama="$namaDepan $namaBelakang"

# for ((i=1; i<=23; i=i+1))
# do
# if [ $i -lt 10 ]
# then
# wget -O Koleksi_0$i https://loremflickr.com/320/240/kitten &>> Foto.log
# else
# wget -O Koleksi_$i https://loremflickr.com/320/240/kitten &>> Foto.log
# fi
# done