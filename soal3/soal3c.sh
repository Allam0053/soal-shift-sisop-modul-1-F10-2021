#!/bin/bash

rm -r ./Kelinci*
rm -r ./Kucing*

downloadFoto() {
  TOTAL_FOTO=23
  totalSama=0
  URL=$1
  FOLDER=$2

  rmdir ./$FOLDER
  mkdir ./$FOLDER
  
  for ((num=1; num<=$TOTAL_FOTO; num=num+1)); do

    # Proses download file
    nomorFile=$(($num - $totalSama))
    fileBaruTerdownload="./Koleksi_$nomorFile"
    if [ $nomorFile -lt 10 ]; then fileBaruTerdownload="./Koleksi_0$nomorFile"; fi
    curl -Lo ./$FOLDER/$fileBaruTerdownload -k $URL
    
    # Iterasi: cek setiap file yg sudah ada apakah ada yang sama dengan yg baru di-download
    for ((i=1; i<$nomorFile; i=i+1)); do
      iterasiFile="./$FOLDER/Koleksi_$i"
      if [ $i -lt 10 ]; then iterasiFile="./$FOLDER/Koleksi_0$i"; fi

      # Jika ada, hapus file, lalu kembali men-download file baru
      adaPersamaan=$(diff $iterasiFile "./$FOLDER/$fileBaruTerdownload")
      if [ -z "$adaPersamaan" ]; then
        totalSama=$(($totalSama + 1))
        rm "./$FOLDER/$fileBaruTerdownload"
        break
      fi
    done
  done
}

tanggal=`date +%s` #penanggalans sejak 1 Januari 1970
danggal=`date +%d-%m-%Y`
let hari=$tanggal/86400

if [ $(( $hari % 2)) -eq 0 ]
then
  downloadFoto https://loremflickr.com/320/240/kitten "Kucing_$danggal"
else
  downloadFoto https://loremflickr.com/320/240/bunny "Kelinci_$danggal"
fi
