#!/bin/bash

for ((i=1; i<=23; i=i+1))
do
if [ $i -lt 10 ]
then
wget -P /home/dewanggad99/kitten -O Koleksi_0${i} https://loremflickr.com/320/240/kitten &>> /home/dewanggad99/kitten/testtest.txt
else
wget -P ~/kitten -O Koleksi_${i} https://loremflickr.com/320/240/kitten &>> ~/kitten/testtest.txt
fi
for ((j=1; j<i; j=j+1))
do
if [ $j -lt 10 ]
then
if
done
done



