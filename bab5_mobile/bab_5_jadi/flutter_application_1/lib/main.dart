

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/books_list_screen.dart';
import 'screens/books_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Buku',
      theme: ThemeData(
        useMaterial3: true, // Menggunakan Material You
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Roboto', // Anda bisa mengganti ke font favorit
      ),
      home: const BooksListScreen(),
    );
  }
}
 