#!/bin/bash

# BEGIN {
#     colors[1] = "Green"
#     colors[2] = "Yellow"
#     colors[3] = "Blue"
#     colors[4] = "Brown"
#     colors[5] = "White"
#   }

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
  }
' Laporan-TokoShiSop.tsv


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
      print $7
      requestPush(arr, $7)
    }
  }

  END {
    # print "\n========"
    # for (ie in arr) {
    #   print arr[ie]
    # }
  }
' Laporan-TokoShiSop.tsv


# ./soal2_generate_laporan_ihir_shisop.sh