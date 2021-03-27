# soal-shift-sisop-modul-1-F10-2021

2.  Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang. Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

    - Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage,

      `Profit Percentage = (Profit Cost Price) 100`

      Cost Price didapatkan dari pengurangan Sales dengan Profit. (Quantity diabaikan).

    - Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar nama customer pada transaksi tahun 2017 di Albuquerque.

    - TokoShiSop berfokus tiga segment customer, antara lain: Home Office, Customer, dan Corporate. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan segment customer dan jumlah transaksinya yang paling sedikit.

    - TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: Central, East, South, dan West. Manis ingin mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

    - Agar mudah dibaca oleh Manis, Clemong, dan Steven, kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:

            Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

            Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
            *Nama Customer1*
            *Nama Customer2* dst

            Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

            Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*

    > Catatan:
    > Gunakan bash, AWK, dan command pendukung
    > Script pada poin (e) memiliki nama file ‘soal2_generate_laporan_ihir_shisop.sh

    ## Penyelesaian nomor 2

    - `Nomor 2a` Scriptnya dapat dilihat [disini](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L3). Berikut adalah penjelasan scriptnya:
      - `NR != 1` Men-skip baris 1 karena isinya adalah judul field (bukan data)
      - `currentProfit = calcProfitPercentage($18, $21)` Menghitung profit dengan batuan user-defined function `calcProfitPercentage()`. Pada dasarnya fungsi itu hanya menghitung profit dengan rumus yang sudah diberitahu pada soal
      - `if (currentProfit >= biggestProfit) { biggestProfit = currentProfit id = $1 }`
        Untuk mengecek jika profit yang dihitung sekarang lebih besar/sama dengan dari perhitungan profit sebelumnya. Jika benar maka simpan data `id` nya
      - `printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%s.\n\n", id, biggestProfit, "%")`
        Untuk menampilkan `id` dengan profit terbesar dengan format kalimat sesuai soal
    - `Nomor 2b` Scriptnya dapat dilihat [disini](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L27). Berikut adalah penjelasan scriptnya:

      - `NR != 1 && $10 == "Albuquerque"` Men-skip baris 1 karena isinya adalah judul field (bukan data) dan memilih baris data yang kolom-10 nya adalah "Albuquerque"
      - `split($3, date, "-")` Untuk kolom-3 (datanya berupa string), pisahkan stringnya berdasarkan karakter "`-`" menjadi array yang disimpan pada variable `date` menggunakan built-in function `split()`
      - `if (date[3] == 17) { requestPush(arr, $7) }`
        Untuk mengecek apakah sekarang tahun 2017. Jika benar maka data (kolom-7) akan disimpan pada array `arr`. `requestPush()` adalah user-defined function yang pada dasarnya fungsi ini melakukan pengecekan sebuah data yang ingin disimpan ke dalam array. Data baru akan disimpan jika dan hanya jika array belum memiliki data baru tersebut.
      -       printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain: \n")
              for (ie in arr) print arr[ie]
              print " "
        Menampilkan data yang sudah disimpan pada array `arr` dengan format kalimat sesuai pada soal

    - `Nomor 2c` Scriptnya dapat dilihat [disini](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L58). Berikut adalah penjelasan scriptnya:
      - `NR != 1` Men-skip baris 1 karena isinya adalah judul field (bukan data)
      -       if ($8 == "Consumer") totalConsumer++
              if ($8 == "Corporate") totalCorporate++
              if ($8 == "Home Office") totalHomeOffice++
        Mengecek jika data kolom-8 sesuai dengan kondisi, maka kemunculannya akan dihitung dengan meng-increment pada variabel terkait.
      - `leastCount = angkaTerkecil3(totalConsumer, totalHomeOffice, totalCorporate)`
        Untuk mencari & menyimpan nilai terkecil dari variabel `totalConsumer`, `totalHomeOffice`, `totalCorporate` dengan bantuan user-defined function `angkaTerkecil3()`.
      -       if (leastCount == totalConsumer) leastSector = "Consumer"
              if (leastCount == totalHomeOffice) leastSector = "Home Office"
              if (leastCount == totalCorporate) leastSector = "Corporate"
        Mengecek untuk menentukan sektor mana yang memiliki kemunculan terkecil.
      - `printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n\n", leastSector, leastCount)`
        Menampilkan segmen penjualan paling sedikit dengan format kaliamt sesuai pada soal.
    - `Nomor 2d` Scriptnya dapat dilihat [disini](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L90). Berikut adalah penjelasan scriptnya:
      - `NR != 1` Men-skip baris 1 karena isinya adalah judul field (bukan data).
      -       if ($13 == "Central") totalCentral += $21
              if ($13 == "East") totalEast += $21
              if ($13 == "West") totalWest += $21
              if ($13 == "South") totalSouth += $21
        Menghitung total profit (ada pada kolom-21) berdasarkan daerahnya.
      - `leastProfit = angkaTerkecil4(totalCentral, totalEast, totalWest, totalSouth)`
        Mencari profit terkecil dengan bantuan user-defined function `angkaTerkecil4()`
      -       if (leastProfit == totalCentral) leastRegion = "Central"
              if (leastProfit == totalEast) leastRegion = leastRegion " East"
              if (leastProfit == totalWest) leastRegion = leastRegion " West"
              if (leastProfit == totalSouth) leastRegion = leastRegion " South"
        Menentukan daerah mana yang profitnya paling kecil.
      -       printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.2f\n", leastRegion, leastProfit)
        Menampilkan wilayah & proft dengan profit terkecil sesuai format kalimat pada soal.
    - `Nomor 2e` Sudah dilakukan bersamaan dengan poin a, b, c, d pada setiap akhir scriptnya. Detail line scriptnya bisa akses dibawah ini:
      | 2e sudah pada tiap poin soal | Detail line code script |
      | ------ | ------ |
      | 2a | [line 24](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L24) |
      | 2b | [line 55](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L55) |
      | 2c | [line 87](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L87) |
      | 2d | [line 123](https://github.com/Allam0053/soal-shift-sisop-modul-1-F10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh#L123) |

3.  Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian.

##Penyelesaian nomor 3 dan masalah-masalah yang ditemukan

3a. Membuat script untuk mengunduh 23 gambar kucing dari https://loremflickr.com/320/240/kitten, membuat file log Foto.log untuk mencatat log pengunduhannya, menghapus gambar-gambar yang sama, menyimpan gambar kucing tersebut dengan format nama Koleksi_XX
3b. Membuat crontab untuk menjalankan script sehari sekali pada jam 8 malam pada tanggal-tanggal tertentu (Seminggu sekali mulai tanggal 1 dan empat hari sekali mulai tanggal 2). Script yang dijalankan memindah semua gambar serta log-nya ke dalam folder dengan nama tanggal unduhannya
3c. Membuat script untuk mengunduh gambar kelinci dari https://loremflickr.com/320/240/bunny dan gambar kucing dari situs di nomor 3a secara bergantian dan disimpan pada folder yang berbeda (Kucing_tanggal dan Kelinci_tanggal)
3d. Membuat script untuk membuat zip sebuah folder yang berisi foto-foto tadi dan membuat password untuk zip tersebut berupa tanggal pembuatan zip
3e. Membuat crontab untuk menjalankan script pada 3d setiap hari kerja (Senin sampai Jumat) pada jam 7 pagi. Lalu, diluar waktu tersebut, file zip tadi di-unzip dan file zip tadi dihapus
