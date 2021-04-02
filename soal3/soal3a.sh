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

TOTAL_FOTO=23
totalSama=0

for ((num=1; num<=$TOTAL_FOTO; num=num+1)); do

  # Proses download file
  nomorFile=$(($num - $totalSama))
  fileBaruTerdownload="Koleksi_$nomorFile"
  if [ $nomorFile -lt 10 ]; then fileBaruTerdownload="Koleksi_0$nomorFile"; fi
  curl -Lo ./$fileBaruTerdownload -k https://loremflickr.com/320/240/kitten 2>> Foto.log
  
  # Iterasi: cek setiap file yg sudah ada apakah ada yang sama dengan yg baru di-download
  for ((i=1; i<$nomorFile; i=i+1)); do
    iterasiFile="Koleksi_$i"
    if [ $i -lt 10 ]; then iterasiFile="Koleksi_0$i"; fi

    # Jika ada, hapus file, lalu kembali men-download file baru
    adaPersamaan=$(diff $iterasiFile $fileBaruTerdownload)
    if [ -z "$adaPersamaan" ]; then
      totalSama=$(($totalSama + 1))
      rm $fileBaruTerdownload
      break
    fi
  done
done

echo -e "\nAda $totalSama file yang sama\n"

# for ((i=1; i<=$TOTAL_FOTO; i=i+1)); do

#   # Penyesuaian nama file 1 & guard clause
#   file1="Koleksi_$i"
#   if [ $i -lt 10 ]; then file1="Koleksi_0$i"; fi
#   if [ ! -f $file1 ]; then continue; fi

#   for ((j=1; j<=$TOTAL_FOTO; j=j+1)); do

#     # Penyesuaian nama file 2 & guard clause
#     file2="Koleksi_$j"
#     if [ $j -lt 10 ]; then file2="Koleksi_0$j"; fi
#     if [ $i == $j -o ! -f $file2 ]; then continue; fi
    
#     fileSama=$(diff $file1 $file2)

#     if [ -z $fileSama ]; then 
#       # echo -e "\n$i == $j\n"
#       sama=$(($sama+1))
#       rm $file2
#     fi
#   done
# done

# echo -e "\nada $sama file yang sama\n"

# for ((i=1; i<=$TOTAL_FOTO; i=i+1)); do
#   for ((j=1; j<=$TOTAL_FOTO; j=j+1)); do

#   done
# done

# Penyesuaian nama file
# for ((i=1; i<$TOTAL_FOTO; i=i+1)); do
#   lebihSatu=$(($i+1))
#   fileKosong="Koleksi_$i"
#   fileSetelahKosong="Koleksi_$lebihSatu"

#   # Penyesuaian nama file 1 & guard clause
#   if [ $lebihSatu -lt 10 ]; then fileSetelahKosong="Koleksi_0$lebihSatu"; fi
#   if [ $i -lt 10 ]; then fileKosong="Koleksi_0$i"; fi
#   if [ ! -f $fileSetelahKosong ]; then break; fi

#   mv $fileSetelahKosong $fileKosong
# done

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