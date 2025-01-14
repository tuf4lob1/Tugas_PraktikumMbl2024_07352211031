import 'package:flutter/material.dart';
import 'package:petcare/login/loginpages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer untuk berpindah ke halaman login
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPages()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF125587), // Warna utama aplikasi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo atau gambar splash screen
            SizedBox(
              height: 150,
              child: Image.asset(
                'assets/images/background.png', // Ganti dengan logo aplikasi
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Nama aplikasi
            const Text(
              'PetCare',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Subjudul atau tagline
            const Text(
              'Membantu Merawat Hewan Peliharaan Anda',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
