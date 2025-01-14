// import 'package:flutter/material.dart';
// import 'package:petcare/user/pesanlayanan.dart';

// class Jadwalscreen extends StatelessWidget {
//   const Jadwalscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: JadwalList(),
//     );
//   }
// }

// class JadwalList extends StatelessWidget {
//   const JadwalList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF125587),
//       padding: const EdgeInsets.all(16.0),
//       child: ListView.builder(
//         itemCount: 3, // Ubah sesuai jumlah jadwal
//         itemBuilder: (context, index) {
//           return const JadwalCard();
//         },
//       ),
//     );
//   }
// }

// class JadwalCard extends StatelessWidget {
//   const JadwalCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               JadwalHeader(),
//               SizedBox(height: 8),
//               JadwalDate(),
//               SizedBox(height: 8),
//               JadwalInputField(),
//               SizedBox(height: 12),
//               JadwalButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class JadwalHeader extends StatelessWidget {
//   const JadwalHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       children: [
//         Icon(
//           Icons.calendar_today,
//           color: Color(0xFF125587),
//         ),
//         SizedBox(width: 8),
//         Text(
//           'Tanggal Konsultasi',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class JadwalDate extends StatelessWidget {
//   const JadwalDate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       '5 Desember 2024',
//       style: TextStyle(fontSize: 14, color: Colors.black54),
//     );
//   }
// }

// class JadwalInputField extends StatelessWidget {
//   const JadwalInputField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const TextField(
//       decoration: InputDecoration(
//         labelText: 'Nama',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }

// class JadwalButton extends StatelessWidget {
//   const JadwalButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const LayananScreen()),
//         );
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF125587),
//       ),
//       child: const Center(
//         child: Text(
//           'Pilih',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }





















import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:petcare/user/pesanlayanan.dart';

class Jadwalscreen extends StatefulWidget {
  const Jadwalscreen({super.key});

  @override
  _JadwalscreenState createState() => _JadwalscreenState();
}

class _JadwalscreenState extends State<Jadwalscreen> {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('jadwal');
  // ignore: unused_field
  late DatabaseEvent _jadwalEvent;
  List<Map<String, String>> jadwalList = [];

  @override
  void initState() {
    super.initState();
    _getJadwalData();
  }

  Future<void> _getJadwalData() async {
    _databaseRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final List<Map<String, String>> loadedJadwal = [];
        data.forEach((key, value) {
          loadedJadwal.add({
            "tanggal": value["tanggal"] ?? "",
            "nama": value["nama"] ?? "",
          });
        });
        setState(() {
          jadwalList = loadedJadwal;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JadwalList(jadwalList: jadwalList),
    );
  }
}

class JadwalList extends StatelessWidget {
  final List<Map<String, String>> jadwalList;

  const JadwalList({super.key, required this.jadwalList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF125587),
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: jadwalList.length,
        itemBuilder: (context, index) {
          return JadwalCard(
            tanggal: jadwalList[index]["tanggal"] ?? '',
            nama: jadwalList[index]["nama"] ?? '',
          );
        },
      ),
    );
  }
}

class JadwalCard extends StatelessWidget {
  final String tanggal;
  final String nama;

  const JadwalCard({super.key, required this.tanggal, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JadwalHeader(),
              SizedBox(height: 8),
              JadwalDate(tanggal: tanggal),
              SizedBox(height: 8),
              JadwalInputField(nama: nama),
              SizedBox(height: 12),
              JadwalButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class JadwalHeader extends StatelessWidget {
  const JadwalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: Color(0xFF125587),
        ),
        SizedBox(width: 8),
        Text(
          'Tanggal Konsultasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class JadwalDate extends StatelessWidget {
  final String tanggal;

  const JadwalDate({super.key, required this.tanggal});

  @override
  Widget build(BuildContext context) {
    return Text(
      tanggal,
      style: const TextStyle(fontSize: 14, color: Colors.black54),
    );
  }
}

class JadwalInputField extends StatelessWidget {
  final String nama;

  const JadwalInputField({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: nama),
      decoration: const InputDecoration(
        labelText: 'Nama',
        border: OutlineInputBorder(),
      ),
      readOnly: true,
    );
  }
}

class JadwalButton extends StatelessWidget {
  const JadwalButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LayananScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF125587),
      ),
      child: const Center(
        child: Text(
          'Pilih',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
