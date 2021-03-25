#!/bin/bash

awk -F"\t" '
  func calcProfitPercentage(sales, profit) {
    costPrice = sales - profit;
    if (costPrice == 0) return 0
    return profit / costPrice * 100;
  }
  
  NR != 1 { # point a
    currentProfit = calcProfitPercentage($18, $21)
    if (currentProfit >= biggestProfit) {
      biggestProfit = currentProfit
      id = $1
    }
  }

  END {
    # print "Biggest profit =", biggestProfit
    # print "Sales id =", id
    printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%s.\n\n", id, biggestProfit, "%")
  }
' Laporan-TokoShiSop.tsv > hasil.txt



awk -F"\t" '
  func arrayLength(arr) {
    for (i in arr) panjang++
    return panjang
  }
  func requestPush(arr, item) {
    for (ie in arr) {
      if (arr[ie] == item) return
    }
    panjang = arrayLength(arr)
    arr[panjang+1] = item
  }

  NR != 1 && $10 == "Albuquerque" {
    split($3, date, "-")

    if (date[3] == 17) {
      # print $7
      requestPush(arr, $7)
    }
  }

  END {
    printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain: \n")
    for (ie in arr) {
      print arr[ie]
    }
    print " "
  }
' Laporan-TokoShiSop.tsv >> hasil.txt



awk -F"\t" '
  func angkaTerkecil(a, b) {
    return a < b ? a : b
  }
  func angkaTerkecil3(a, b, c) {
    return angkaTerkecil(a, angkaTerkecil(b, c))
  }

  NF != 1 {
    if ($8 == "Consumer") totalConsumer++
    if ($8 == "Corporate") totalCorporate++
    if ($8 == "Home Office") totalHomeOffice++
  }

  END {
    leastCount = angkaTerkecil3(totalConsumer, totalHomeOffice, totalCorporate)
    
    if (leastCount == totalConsumer) leastSector = "Consumer"
    if (leastCount == totalHomeOffice) leastSector = "Home Office"
    if (leastCount == totalCorporate) leastSector = "Corporate"

    # print "Least sector is", leastSector, " with", leastCount, " sales\n"
    # print "Home Office:", totalHomeOffice
    # print "Consumer:", totalConsumer
    # print "Corporate:", totalCorporate

    printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n\n", leastSector, leastCount)
  }
' Laporan-TokoShiSop.tsv >> hasil.txt



awk -F"\t" '
  func terkecil(a, b) {
    return a < b ? a : b
  }
  func angkaTerkecil4(a, b, c, d) {
    return terkecil(a, terkecil(b, terkecil(c, d)))
  }

  NF != 1 {
    if ($13 == "Central") totalCentral += $21
    if ($13 == "East") totalEast += $21
    if ($13 == "West") totalWest += $21
    if ($13 == "South") totalSouth += $21
  }

  END {
    leastProfit = angkaTerkecil4(totalCentral, totalEast, totalWest, totalSouth)
    
    if (leastProfit == totalCentral) leastRegion = "Central"
    if (leastProfit == totalEast) leastRegion = leastRegion " East"
    if (leastProfit == totalWest) leastRegion = leastRegion " West"
    if (leastProfit == totalSouth) leastRegion = leastRegion " South"

    # print "Least region is", leastRegion, " with $", leastProfit, "\n"
    
    # print "Central:", totalCentral
    # print "East:", totalEast
    # print "West:", totalWest
    # print "South:", totalSouth

    printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.2f\n", leastRegion, leastProfit)
  }
' Laporan-TokoShiSop.tsv >> hasil.txt


# ./soal2_generate_laporan_ihir_shisop.sh