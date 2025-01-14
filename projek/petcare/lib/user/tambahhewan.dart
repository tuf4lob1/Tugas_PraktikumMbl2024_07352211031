// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class TambahHewan extends StatefulWidget {
//   const TambahHewan({super.key});

//   @override
//   _TambahHewanState createState() => _TambahHewanState();
// }

// class _TambahHewanState extends State<TambahHewan> {
//   final _namaController = TextEditingController();
//   final _jenisController = TextEditingController();
//   final _rasController = TextEditingController();
//   final _penyakitController = TextEditingController();

//   final DatabaseReference _database = FirebaseDatabase.instance.ref();

// /*************  ✨ Codeium Command ⭐  *************/
//   /// Menyimpan data hewan peliharaan ke Firebase Realtime Database.
//   ///
//   /// Fungsi ini akan memeriksa apakah nama, jenis, dan ras tidak kosong.
//   /// Jika tidak kosong, maka data akan disimpan ke database.
//   /// Jika berhasil, maka akan menampilkan snackbar dengan status success.
// /******  430b747f-f1cd-472f-99cc-d04bc0f261e2  *******/
//   void _saveData() {
//     final nama = _namaController.text;
//     final jenis = _jenisController.text;
//     final ras = _rasController.text;
//     final penyakit = _penyakitController.text;

//     if (nama.isNotEmpty && jenis.isNotEmpty && ras.isNotEmpty) {
//       // Menyimpan data ke Firebase Realtime Database
//       _database.child('hewan').push().set({
//         'nama': nama,
//         'jenis': jenis,
//         'ras': ras,
//         'penyakit': penyakit,
//       }).then((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Data Hewan Berhasil Ditambahkan'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         _clearFields();
//       }).catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Gagal menambahkan data: $error'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       });
//     }
//   }

//   void _clearFields() {
//     _namaController.clear();
//     _jenisController.clear();
//     _rasController.clear();
//     _penyakitController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color(0xFF125587),
//         title: const Text('PetCare', style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         color: const Color(0xFF125587),
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             const Center(
//               child: Text(
//                 'Tambahkan Hewan Peliharaan',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Divider(color: Colors.white),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _namaController,
//               decoration: const InputDecoration(
//                 labelText: 'Nama hewan',
//                 hintText: 'Masukkan nama hewan',
//                 labelStyle: TextStyle(color: Colors.black),
//                 hintStyle: TextStyle(color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _jenisController,
//               decoration: const InputDecoration(
//                 labelText: 'Jenis hewan',
//                 hintText: 'Jenis hewan',
//                 labelStyle: TextStyle(color: Colors.black),
//                 hintStyle: TextStyle(color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _rasController,
//               decoration: const InputDecoration(
//                 labelText: 'Ras',
//                 hintText: 'Ras',
//                 labelStyle: TextStyle(color: Colors.black),
//                 hintStyle: TextStyle(color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _penyakitController,
//               decoration: const InputDecoration(
//                 labelText: 'Riwayat Penyakit',
//                 hintText: 'Masukkan Riwayat Penyakit Jika Ada',
//                 labelStyle: TextStyle(color: Colors.black),
//                 hintStyle: TextStyle(color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _saveData,
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.blue[700],
//                   backgroundColor: Colors.white,
//                 ),
//                 child: const Text('Simpan'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




























import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahHewan extends StatefulWidget {
  const TambahHewan({super.key});

  @override
  _TambahHewanState createState() => _TambahHewanState();
}

class _TambahHewanState extends State<TambahHewan> {
  final _namaController = TextEditingController();
  final _jenisController = TextEditingController();
  final _rasController = TextEditingController();
  final _penyakitController = TextEditingController();

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Mendapatkan ID pengguna dari SharedPreferences
  Future<String?> _getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Menyimpan data hewan
  void _saveData() async {
    final nama = _namaController.text;
    final jenis = _jenisController.text;
    final ras = _rasController.text;
    final penyakit = _penyakitController.text;

    // Dapatkan ID pengguna saat ini
    final userId = await _getCurrentUserId();
    
    if (userId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sesi login tidak valid. Silakan login kembali.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (nama.isEmpty || jenis.isEmpty || ras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama, jenis, dan ras hewan harus diisi!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Simpan data hewan di bawah node user ID
      await _database.child('users').child(userId).child('hewan').push().set({
        'nama': nama,
        'jenis': jenis,
        'ras': ras,
        'penyakit': penyakit,
        'timestamp': ServerValue.timestamp,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Hewan Berhasil Ditambahkan'),
          backgroundColor: Colors.green,
        ),
      );
      _clearFields();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan data: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Membersihkan field input
  void _clearFields() {
    _namaController.clear();
    _jenisController.clear();
    _rasController.clear();
    _penyakitController.clear();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _rasController.dispose();
    _penyakitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF125587),
        title: const Text('PetCare', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFF125587),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Tambahkan Hewan Peliharaan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white),
              const SizedBox(height: 20),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama hewan',
                  hintText: 'Masukkan nama hewan',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _jenisController,
                decoration: const InputDecoration(
                  labelText: 'Jenis hewan',
                  hintText: 'Jenis hewan',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _rasController,
                decoration: const InputDecoration(
                  labelText: 'Ras',
                  hintText: 'Ras',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _penyakitController,
                decoration: const InputDecoration(
                  labelText: 'Riwayat Penyakit',
                  hintText: 'Masukkan Riwayat Penyakit Jika Ada',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue[700],
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}