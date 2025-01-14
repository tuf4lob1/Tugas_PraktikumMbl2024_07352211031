// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class LihatHewan extends StatefulWidget {
//   const LihatHewan({super.key});

//   @override
//   _LihatHewanState createState() => _LihatHewanState();
// }

// class _LihatHewanState extends State<LihatHewan> {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   List<Map<String, String>> hewanList = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   void _fetchData() {
//     _database.child('hewan').onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;
//       final List<Map<String, String>> loadedData = [];
//       if (data != null) {
//         data.forEach((key, value) {
//           loadedData.add({
//             'nama': value['nama'] ?? '',
//             'jenis': value['jenis'] ?? '',
//             'ras': value['ras'] ?? '',
//             'riwayat': value['penyakit'] ?? '',
//           });
//         });
//       }
//       setState(() {
//         hewanList = loadedData;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const _LihatHewanAppBar(),
//       body: _HewanList(hewanList: hewanList),
//     );
//   }
// }

// class _LihatHewanAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const _LihatHewanAppBar();

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       backgroundColor: const Color(0xFF125587),
//       iconTheme: const IconThemeData(color: Colors.white),
//       title: const Text(
//         'Daftar Hewan Peliharaan',
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _HewanList extends StatelessWidget {
//   final List<Map<String, String>> hewanList;

//   const _HewanList({required this.hewanList});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF125587),
//       padding: const EdgeInsets.all(16.0),
//       child: hewanList.isEmpty
//           ? const Center(
//               child: Text(
//                 'Belum ada data hewan',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             )
//           : ListView.builder(
//               itemCount: hewanList.length,
//               itemBuilder: (context, index) {
//                 final hewan = hewanList[index];
//                 return _HewanCard(hewan: hewan);
//               },
//             ),
//     );
//   }
// }

// class _HewanCard extends StatelessWidget {
//   final Map<String, String> hewan;

//   const _HewanCard({required this.hewan});

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
//           hewan['nama']!,
//           style: const TextStyle(
//             color: Colors.blue,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Text(
//           'Jenis: ${hewan['jenis']!}\nRas: ${hewan['ras']!}\nRiwayat: ${hewan['riwayat']!}',
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }























import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LihatHewan extends StatefulWidget {
  const LihatHewan({super.key});

  @override
  _LihatHewanState createState() => _LihatHewanState();
}

class _LihatHewanState extends State<LihatHewan> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, String>> hewanList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<String?> _getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  void _fetchData() async {
    final userId = await _getCurrentUserId();

    if (userId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sesi login tidak valid. Silakan login kembali.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _database
        .child('users')
        .child(userId) // Filter data berdasarkan userId
        .child('hewan')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      final List<Map<String, String>> loadedData = [];

      if (data != null) {
        data.forEach((key, value) {
          loadedData.add({
            'id': key,
            'nama': value['nama'] ?? '',
            'jenis': value['jenis'] ?? '',
            'ras': value['ras'] ?? '',
            'riwayat': value['penyakit'] ?? '',
          });
        });
      }

      if (mounted) {
        setState(() {
          hewanList = loadedData;
          _isLoading = false;
        });
      }
    }, onError: (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _LihatHewanAppBar(),
      body: _HewanList(
        hewanList: hewanList,
        isLoading: _isLoading,
      ),
    );
  }
}

class _LihatHewanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _LihatHewanAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color(0xFF125587),
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        'Daftar Hewan Peliharaan',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HewanList extends StatelessWidget {
  final List<Map<String, String>> hewanList;
  final bool isLoading;

  const _HewanList({
    required this.hewanList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF125587),
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : hewanList.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada data hewan',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: hewanList.length,
                  itemBuilder: (context, index) {
                    final hewan = hewanList[index];
                    return _HewanCard(hewan: hewan);
                  },
                ),
    );
  }
}

class _HewanCard extends StatelessWidget {
  final Map<String, String> hewan;

  const _HewanCard({required this.hewan});

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
          hewan['nama']!,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Jenis: ${hewan['jenis']!}',
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              'Ras: ${hewan['ras']!}',
              style: const TextStyle(color: Colors.black),
            ),
            if (hewan['riwayat']!.isNotEmpty)
              Text(
                'Riwayat: ${hewan['riwayat']!}',
                style: const TextStyle(color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
