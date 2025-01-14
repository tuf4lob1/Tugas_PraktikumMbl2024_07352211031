// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class DataHewanPage extends StatefulWidget {
//   const DataHewanPage({super.key});

//   @override
//   State<DataHewanPage> createState() => _DataHewanPageState();
// }

// class _DataHewanPageState extends State<DataHewanPage> {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   List<Map<String, dynamic>> _hewanList = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchHewanData();
//   }

//   void _fetchHewanData() {
//     _database.child('hewan').onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;
//       if (data != null) {
//         setState(() {
//           _hewanList = data.entries.map((e) {
//             return {
//               'key': e.key,
//               'nama': e.value['nama'],
//               'jenis': e.value['jenis'],
//               'ras': e.value['ras'],
//               'penyakit': e.value['penyakit'],
//             };
//           }).toList();
//         });
//       } else {
//         setState(() {
//           _hewanList = [];
//         });
//       }
//     });
//   }

//   void _deleteHewan(String key) {
//     _database.child('hewan/$key').remove().then((_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Data berhasil dihapus'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     }).catchError((error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Gagal menghapus data: $error'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF125587),
//         title: const Text(
//           'Data Hewan',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Container(
//         color: const Color(0xFF125587),
//         padding: const EdgeInsets.all(16.0),
//         child: _buildHewanList(),
//       ),
//     );
//   }

//   Widget _buildHewanList() {
//     if (_hewanList.isEmpty) {
//       return const Center(
//         child: Text(
//           'Tidak ada data hewan',
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: _hewanList.length,
//       itemBuilder: (context, index) {
//         return _HewanCard(
//           hewan: _hewanList[index],
//           onDelete: () => _confirmDelete(context, _hewanList[index]['key']),
//         );
//       },
//     );
//   }

//   void _confirmDelete(BuildContext context, String key) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Hapus Data'),
//         content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(ctx).pop(),
//             child: const Text('Batal'),
//           ),
//           TextButton(
//             onPressed: () {
//               _deleteHewan(key);
//               Navigator.of(ctx).pop();
//             },
//             child: const Text(
//               'Hapus',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _HewanCard extends StatelessWidget {
//   final Map<String, dynamic> hewan;
//   final VoidCallback onDelete;

//   const _HewanCard({
//     required this.hewan,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(16.0),
//         title: Text(
//           hewan['nama'],
//           style: const TextStyle(
//             color: Colors.blue,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Text(
//           'Jenis: ${hewan['jenis']}\nRas: ${hewan['ras']}\nRiwayat: ${hewan['penyakit']}',
//           style: const TextStyle(color: Colors.black),
//         ),
//         trailing: IconButton(
//           icon: const Icon(Icons.delete, color: Colors.red),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }
// }


























import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataHewanPage extends StatefulWidget {
  const DataHewanPage({super.key});

  @override
  State<DataHewanPage> createState() => _DataHewanPageState();
}

class _DataHewanPageState extends State<DataHewanPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> _hewanList = [];

  @override
  void initState() {
    super.initState();
    _fetchHewanData();
  }

  // Mendapatkan ID pengguna dari SharedPreferences
  Future<String?> _getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Mengambil data hewan berdasarkan ID pengguna
  void _fetchHewanData() async {
    final userId = await _getCurrentUserId();
    
    if (userId != null) {
      _database.child('users').child(userId).child('hewan').onValue.listen((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          setState(() {
            _hewanList = data.entries.map((e) {
              return {
                'key': e.key,
                'nama': e.value['nama'],
                'jenis': e.value['jenis'],
                'ras': e.value['ras'],
                'penyakit': e.value['penyakit'],
              };
            }).toList();
          });
        } else {
          setState(() {
            _hewanList = [];
          });
        }
      });
    }
  }

  // Menghapus data hewan
  void _deleteHewan(String key) {
    _database.child('users').child(key).child('hewan').remove().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dihapus'),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus data: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color(0xFF125587),
        title: const Text(
          'Data Hewan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: const Color(0xFF125587),
        padding: const EdgeInsets.all(16.0),
        child: _buildHewanList(),
      ),
    );
  }

  Widget _buildHewanList() {
    if (_hewanList.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada data hewan',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: _hewanList.length,
      itemBuilder: (context, index) {
        return _HewanCard(
          hewan: _hewanList[index],
          onDelete: () => _confirmDelete(context, _hewanList[index]['key']),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, String key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Data'),
        content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _deleteHewan(key);
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _HewanCard extends StatelessWidget {
  final Map<String, dynamic> hewan;
  final VoidCallback onDelete;

  const _HewanCard({
    required this.hewan,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          hewan['nama'],
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Jenis: ${hewan['jenis']}\nRas: ${hewan['ras']}\nRiwayat: ${hewan['penyakit']}',
          style: const TextStyle(color: Colors.black),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

