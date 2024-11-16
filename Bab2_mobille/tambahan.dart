// Enum untuk tipe kendaraan
enum TipeKendaraan { Mobil, Motor }

// Abstract class Kendaraan
abstract class Kendaraan {
  final String merk;
  final int tahun;

  Kendaraan(this.merk, this.tahun);

  // Abstract method (harus diimplementasikan oleh subclass)
  void infoKendaraan();
}

// Mixin untuk fitur tambahan
mixin Nyaman {
  void fiturNyaman() {
    print("Kendaraan ini memiliki fitur kenyamanan tinggi.");
  }
}

// Class Mobil yang mewarisi Kendaraan dan menggunakan mixin Nyaman
class Mobil extends Kendaraan with Nyaman {
  double _harga; // Private attribute untuk harga

  // Constructor dengan positional dan named arguments
  Mobil(String merk, int tahun, {required double harga})
      : _harga = harga,
        super(merk, tahun);

  // Getter untuk harga
  double get harga => _harga;

  // Setter untuk harga
  set harga(double nilaiBaru) {
    if (nilaiBaru > 0) {
      _harga = nilaiBaru;
    } else {
      print("Harga harus lebih besar dari 0.");
    }
  }

  // Implementasi method dari abstract class
  @override
  void infoKendaraan() {
    print("Ini adalah mobil $merk keluaran tahun $tahun dengan harga $_harga.");
  }
}

// Class Motor yang mewarisi Kendaraan
class Motor extends Kendaraan {
  // Constructor dengan positional arguments
  Motor(String merk, int tahun) : super(merk, tahun);

  // Implementasi method dari abstract class
  @override
  void infoKendaraan() {
    print("Ini adalah motor $merk keluaran tahun $tahun.");
  }
}

void main() {
  // Membuat objek Mobil dengan positional dan named arguments
  Mobil mobil = Mobil("Toyota", 2022, harga: 300000000);
  mobil.infoKendaraan(); // Memanggil method
  mobil.fiturNyaman(); // Memanggil method dari mixin

  // Menggunakan getter dan setter
  print("Harga mobil: ${mobil.harga}");
  mobil.harga = 350000000; // Mengubah harga dengan setter
  print("Harga mobil yang baru: ${mobil.harga}");

  // Membuat objek Motor
  Motor motor = Motor("Honda", 2020);
  motor.infoKendaraan();

  // Menggunakan enum
  TipeKendaraan tipeMobil = TipeKendaraan.Mobil;
  TipeKendaraan tipeMotor = TipeKendaraan.Motor;

  print("Tipe kendaraan mobil: $tipeMobil");
  print("Tipe kendaraan motor: $tipeMotor");
}
