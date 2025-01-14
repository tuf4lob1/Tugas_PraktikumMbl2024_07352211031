import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.isNotEmpty) {
      final StringBuffer buffer = StringBuffer();
      int count = 0;

      for (int i = newText.length - 1; i >= 0; i--) {
        buffer.write(newText[i]);
        count++;
        if (count == 3 && i != 0) {
          buffer.write('.');
          count = 0;
        }
      }
      newText = buffer.toString().split('').reversed.join('');
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();
  final DatabaseReference _database = FirebaseDatabase.instance.ref('produk');

  Future<void> _pickImage({required ImageSource source}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih gambar: $e')),
      );
    }
  }

  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Ambil path lokal gambar
        String? imagePath = _imageFile?.path;

        // Simpan data produk ke Firebase Realtime Database
        final nama = _namaController.text;
        final harga = _hargaController.text.replaceAll('.', ''); // Harga tanpa titik
        final deskripsi = _deskripsiController.text;

        await _database.push().set({
          'nama': nama,
          'harga': harga,
          'deskripsi': deskripsi,
          'imagePath': imagePath ?? '', // Simpan path lokal gambar
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produk berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan produk: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color(0xFF125587),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF125587),
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama Produk',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _namaController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama produk',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama produk tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Harga Produk',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _hargaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      hintText: 'Masukkan harga produk',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harga produk tidak boleh kosong';
                      }
                      String cleanedValue = value.replaceAll('.', '');
                      if (double.tryParse(cleanedValue) == null) {
                        return 'Masukkan harga yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _deskripsiController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan deskripsi produk',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi produk tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _pickImage(source: ImageSource.gallery);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF125587),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Tambah Gambar Produk',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _uploadData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 28.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Tambah Produk',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  if (_imageFile != null)
                    Column(
                      children: [
                        Image.file(
                          _imageFile!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Path Gambar: ${_imageFile!.path}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
