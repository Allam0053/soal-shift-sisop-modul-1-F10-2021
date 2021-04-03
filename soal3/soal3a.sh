#!/bin/bash

TOTAL_FOTO=23
totalSama=0

# Mulai iterasi download
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