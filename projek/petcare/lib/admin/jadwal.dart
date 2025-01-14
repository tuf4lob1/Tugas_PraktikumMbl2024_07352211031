// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:petcare/admin/editjadwal.dart' show EditJadwalPage, TambahJadwalPage;
import 'package:petcare/admin/tambahjadwal.dart';

class JadwalAdmin {
  String id;
  String tanggal;
  String nama;

  JadwalAdmin({required this.id, required this.tanggal, required this.nama});

  factory JadwalAdmin.fromMap(String id, Map<dynamic, dynamic> map) {
    return JadwalAdmin(
      id: id,
      tanggal: map['tanggal'] ?? '',
      nama: map['nama'] ?? '',
    );
  }
}

class JadwalAdminPage extends StatefulWidget {
  const JadwalAdminPage({super.key});

  @override
  _JadwalAdminPageState createState() => _JadwalAdminPageState();
}

class _JadwalAdminPageState extends State<JadwalAdminPage> {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('jadwal');
  List<JadwalAdmin> jadwalList = [];

  @override
  void initState() {
    super.initState();
    _fetchJadwal();
  }

  void _fetchJadwal() {
    _databaseRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final List<JadwalAdmin> loadedJadwal = [];
        data.forEach((key, value) {
          loadedJadwal.add(JadwalAdmin.fromMap(key, value));
        });
        setState(() {
          jadwalList = loadedJadwal;
        });
      }
    });
  }

  void _deleteJadwal(String id) async {
    await _databaseRef.child(id).remove();
  }

  void _navigateToForm({JadwalAdmin? jadwal}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (jadwal != null) {
            return EditJadwalPage(jadwal: jadwal);
          } else {
            return const TambahJadwalPage();
          }
        },
      ),
    );

    if (result != null) {
      // The list will automatically update because of Firebase listeners.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF125587),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF125587),
      ),
      body: ListView.builder(
        itemCount: jadwalList.length,
        itemBuilder: (context, index) {
          final jadwal = jadwalList[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: const Text(
                "Tanggal Konsultasi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${jadwal.tanggal}\n${jadwal.nama}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _navigateToForm(jadwal: jadwal),
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: "Edit Jadwal",
                  ),
                  IconButton(
                    onPressed: () => _deleteJadwal(jadwal.id),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: "Hapus Jadwal",
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add, color: Color(0xFF125587)),
      ),
    );
  }
}
