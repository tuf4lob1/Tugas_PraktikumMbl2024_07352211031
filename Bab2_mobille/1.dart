enum FaseProyek { perencanaan, pengembangan, evaluasi }

class Karyawan {
  String nama;
  int umur;
  String peran;
  bool aktif = true;
  int produktivitas = 50;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void resign() {
    aktif = false;
  }
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);
}

class Pengembang extends Karyawan {
  Pengembang(String nama, {required int umur})
      : super(nama, umur: umur, peran: "Pengembang");
}

class InsinyurJaringan extends Karyawan {
  InsinyurJaringan(String nama, {required int umur})
      : super(nama, umur: umur, peran: "InsinyurJaringan");
}

class Manajer extends Karyawan {
  Manajer(String nama, {required int umur})
      : super(nama, umur: umur, peran: "Manajer") {
    if (produktivitas > 85) {
      throw Exception("Produktivitas Manajer harus minimal 85");
    }
  }
}

mixin Kinerja on Karyawan {
  DateTime waktuTerakhirUpdate = DateTime.now();

  void updateProduktivitas(int nilai) {
    DateTime sekarang = DateTime.now();
    if (sekarang.difference(waktuTerakhirUpdate).inDays >= 30) {
      produktivitas = (nilai < 0) ? 0 : (nilai > 100) ? 100 : nilai;
      waktuTerakhirUpdate = sekarang;
    } else {
      print("Produktivitas hanya dapat diperbarui setiap 30 hari.");
    }
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < 20) {
      print("\n=== Tambah Karyawan ===");
      karyawanAktif.add(karyawan);
    } else {
      print("Jumlah maksimum karyawan aktif telah tercapai.");
    }
  }

  void hapusKaryawan(Karyawan karyawan) {
    print("\n=== Hapus Karyawan ===");
    karyawanAktif.remove(karyawan);
    karyawan.resign();
    karyawanNonAktif.add(karyawan);
  }
}

class Produk {
  String namaProduk;
  double harga;
  String kategori;
  int jumlahTerjual = 0;

  Produk(this.namaProduk, this.harga, this.kategori) {
    if (kategori == "NetworkAutomation" && harga < 200000) {
      throw Exception("Harga NetworkAutomation harus minimal 200.000");
    } else if (kategori == "DataManagement" && harga >= 200000) {
      throw Exception("Harga DataManagement harus di bawah 200.000");
    }
  }

  void terapkanDiskon() {
    if (kategori == "NetworkAutomation" && jumlahTerjual > 50) {
      double hargaDiskon = harga * 0.15;
      harga = hargaDiskon >= 200000 ? hargaDiskon : 200000;
    }
  }
}

class Proyek {
  String namaProyek;
  FaseProyek fase = FaseProyek.perencanaan;
  List<Karyawan> anggotaTim = [];
  DateTime tanggalMulai = DateTime.now();

  Proyek(this.namaProyek);

  void tambahAnggotaTim(Karyawan karyawan) {
    if (anggotaTim.length < 20) {
      anggotaTim.add(karyawan);
    } else {
      print("Tidak dapat menambah lebih dari 20 karyawan aktif.");
    }
  }

  void lanjutKeFaseBerikutnya() {
    if (fase == FaseProyek.perencanaan && anggotaTim.length >= 5) {
      fase = FaseProyek.pengembangan;
    } else if (fase == FaseProyek.pengembangan &&
        DateTime.now().difference(tanggalMulai).inDays > 45) {
      fase = FaseProyek.evaluasi;
    }
  }
}

void main() {
  // Membuat produk dengan kategori yang berbeda
  var produk1 = Produk("Sistem Manajemen Data", 150000, "DataManagement");
  var produk2 = Produk("Sistem Otomasi Jaringan", 250000, "NetworkAutomation");

  // Menampilkan detail produk sebelum diskon
  print("Nama Produk: ${produk1.namaProduk}, Harga: ${produk1.harga}");
  print("Nama Produk: ${produk2.namaProduk}, Harga: ${produk2.harga}");

  // Terapkan diskon jika memenuhi syarat
  produk2.jumlahTerjual = 60; // Misal produk2 sudah terjual lebih dari 50 unit
  produk2.terapkanDiskon();
  print("Harga produk2 setelah diskon: ${produk2.harga}");

  // Membuat beberapa karyawan
  var karyawan1 = KaryawanTetap("Chanda", umur: 19, peran: "Pengembang");
  var karyawan2 = KaryawanKontrak("Agat", umur: 21, peran: "InsinyurJaringan");
  var karyawan3 = Manajer("Iring", umur: 20);

  // Menampilkan info karyawan
  print("Karyawan 1: ${karyawan1.nama}, Umur: ${karyawan1.umur}, Peran: ${karyawan1.peran}");
  print("Karyawan 2: ${karyawan2.nama}, Umur: ${karyawan2.umur}, Peran: ${karyawan2.peran}");
  print("Karyawan 3: ${karyawan3.nama}, Umur: ${karyawan3.umur}, Peran: ${karyawan3.peran}");

  // Membuat perusahaan dan menambahkan karyawan
  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);
  perusahaan.tambahKaryawan(karyawan3);
  
  // Menampilkan jumlah karyawan aktif di perusahaan
  print("Jumlah karyawan aktif: ${perusahaan.karyawanAktif.length}");

  // Membuat proyek baru 
  var proyek = Proyek("Proyek Transformasi Digital");
  proyek.tambahAnggotaTim(karyawan1);
  proyek.tambahAnggotaTim(karyawan2);
  proyek.tambahAnggotaTim(karyawan3);

  // Lanjutkan fase proyek jika memenuhi syarat
  proyek.lanjutKeFaseBerikutnya();
  print("Fase proyek saat ini: ${proyek.fase}");
}