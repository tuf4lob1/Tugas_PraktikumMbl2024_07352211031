import 'package:flutter/material.dart';
import 'package:petcare/admin/jadwal.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'package:firebase_database/firebase_database.dart';

class TambahJadwalPage extends StatefulWidget {
  const TambahJadwalPage({super.key});

  @override
  _TambahJadwalPageState createState() => _TambahJadwalPageState();
}

class _TambahJadwalPageState extends State<TambahJadwalPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('jadwal');

  @override
  void dispose() {
    tanggalController.dispose();
    namaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        tanggalController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _saveToFirebase() async {
    if (_formKey.currentState!.validate()) {
      final newJadwal = {
        "tanggal": tanggalController.text,
        "nama": namaController.text,
      };

      try {
        await _databaseRef.push().set(newJadwal);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Jadwal berhasil disimpan"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal menyimpan jadwal"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF125587),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Tambah Jadwal", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF125587),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: tanggalController,
                decoration: const InputDecoration(
                  labelText: "Tanggal Konsultasi",
                  filled: true,
                  fillColor: Colors.white,
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tanggal tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveToFirebase,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF125587),
                  backgroundColor: Colors.white,
                ),
                child: const Text("Tambah"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditJadwalPage extends StatefulWidget {
  final JadwalAdmin jadwal;

  const EditJadwalPage({super.key, required this.jadwal});

  @override
  _EditJadwalPageState createState() => _EditJadwalPageState();
}

class _EditJadwalPageState extends State<EditJadwalPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController tanggalController;
  late TextEditingController namaController;
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('jadwal');

  @override
  void initState() {
    super.initState();
    tanggalController = TextEditingController(text: widget.jadwal.tanggal);
    namaController = TextEditingController(text: widget.jadwal.nama);
  }

  @override
  void dispose() {
    tanggalController.dispose();
    namaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        tanggalController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _updateJadwal() async {
    if (_formKey.currentState!.validate()) {
      final updatedJadwal = {
        "tanggal": tanggalController.text,
        "nama": namaController.text,
      };

      try {
        await _databaseRef.child(widget.jadwal.id).update(updatedJadwal);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Jadwal berhasil diperbarui"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal memperbarui jadwal"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF125587),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Edit Jadwal", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF125587),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: tanggalController,
                decoration: const InputDecoration(
                  labelText: "Tanggal Konsultasi",
                  filled: true,
                  fillColor: Colors.white,
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tanggal tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateJadwal,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF125587),
                  backgroundColor: Colors.white,
                ),
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
