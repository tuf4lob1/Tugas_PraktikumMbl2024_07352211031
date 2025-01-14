import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProdukPages extends StatefulWidget {
  const ProdukPages({super.key});

  @override
  State<ProdukPages> createState() => _ProdukPagesState();
}

class _ProdukPagesState extends State<ProdukPages> {
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
                  "imagePath": entry.value["imagePath"] ?? "", // URL atau jalur file lokal
                })
            .toList();
      });
    }
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Produk & Layanan",
          style: TextStyle(color: Colors.white),
        ),
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
                                      image: produk["imagePath"].startsWith("http")
                                          ? NetworkImage(produk["imagePath"])
                                          : FileImage(File(produk["imagePath"])) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.image, size: 80, color: Colors.grey),
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
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}




















