import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:petcare/admin/editproduk.dart';
import 'package:petcare/admin/tambahproduk.dart';

class ProdukPagesAdmin extends StatefulWidget {
  const ProdukPagesAdmin({super.key});

  @override
  State<ProdukPagesAdmin> createState() => _ProdukPagesAdminState();
}

class _ProdukPagesAdminState extends State<ProdukPagesAdmin> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("produk");
  List<Map<String, dynamic>> produkList = [];

  @override
  void initState() {
    super.initState();
    _fetchProdukData();
  }

  Future<void> _fetchProdukData() async {
    final snapshot = await _databaseRef.get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      setState(() {
        produkList = data.entries
            .map((entry) => {
                  "id": entry.key,
                  "nama": entry.value["nama"] ?? "",
                  "deskripsi": entry.value["deskripsi"] ?? "",
                  "harga": entry.value["harga"] ?? "",
                  "imagePath": entry.value["imagePath"] ?? "", // Path gambar
                })
            .toList();
      });
    }
  }

  Future<void> _deleteProduk(String id) async {
    await _databaseRef.child(id).remove();
    _fetchProdukData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produk berhasil dihapus"), backgroundColor: Colors.green),
    );
  }

  // Fungsi untuk memformat harga dengan pemisah ribuan
  String formatHarga(String harga) {
    final number = double.tryParse(harga.replaceAll('.', '').replaceAll('Rp', '').replaceAll(',', '.'));
    if (number != null) {
      final formatted = number.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]}.');
      return 'Rp $formatted';
    }
    return harga;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF125587),
      ),
      body: Container(
        color: const Color(0xFF125587),
        padding: const EdgeInsets.all(16.0),
        child: produkList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : ListView.builder(
                itemCount: produkList.length,
                itemBuilder: (context, index) {
                  final produk = produkList[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          produk["imagePath"].isNotEmpty
                              ? Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(File(produk["imagePath"])),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.image, size: 80),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produk['nama'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  produk['deskripsi'],
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  formatHarga(produk['harga']),
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProdukPage(
                                        idProduk: produk['id'],
                                        namaProduk: produk['nama'],
                                        hargaProduk: produk['harga'],
                                        deskripsiProduk: produk['deskripsi'],
                                        imagePath: produk['imagePath'], imageUrl: '',
                                      ),
                                    ),
                                  ).then((_) => _fetchProdukData());
                                },
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                tooltip: 'Edit Produk',
                              ),
                              IconButton(
                                onPressed: () => _deleteProduk(produk["id"]),
                                icon: const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Hapus Produk',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahProdukPage()),
          ).then((_) => _fetchProdukData());
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
