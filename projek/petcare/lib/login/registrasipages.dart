// import 'package:flutter/material.dart';
// import 'package:petcare/login/loginpages.dart';
// import 'package:firebase_database/firebase_database.dart';

// class RegistrasiPages extends StatefulWidget {
//   const RegistrasiPages({super.key});

//   @override
//   State<RegistrasiPages> createState() => _RegistrasiPagesState();
// }

// class _RegistrasiPagesState extends State<RegistrasiPages> {
//   // Controller untuk inputan
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   // Variabel untuk toggle visibility password
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;

//   // Referensi ke Firebase Realtime Database
//   final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("users");

//   // Fungsi untuk menambahkan data ke Firebase
//   Future<void> _registerUser(String username, String password) async {
//     try {
//       await _databaseRef.push().set({
//         'username': username,
//         'password': password, // Jangan simpan password plaintext dalam aplikasi nyata
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Registrasi berhasil!',
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Navigasi ke halaman login
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPages()),
//         (route) => false,
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Terjadi kesalahan: $error',
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF125587),
//         centerTitle: true,
//         title: const Text(
//           'Registrasi PetCare',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       backgroundColor: const Color(0xFF125587),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: SizedBox(
//                     height: 200,
//                     child: Image.asset(
//                       'assets/images/background.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: "Masukkan Nama (username)",
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   controller: _passwordController,
//                   obscureText: !_isPasswordVisible,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: 'Masukkan password',
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.white54,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   controller: _confirmPasswordController,
//                   obscureText: !_isConfirmPasswordVisible,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: 'Konfirmasi password',
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.white54,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Validasi input
//                       if (_usernameController.text.isEmpty ||
//                           _passwordController.text.isEmpty ||
//                           _confirmPasswordController.text.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text(
//                               'Semua kolom harus diisi!',
//                               textAlign: TextAlign.center,
//                             ),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       } else if (_passwordController.text != _confirmPasswordController.text) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text(
//                               'Password dan konfirmasi password tidak cocok!',
//                               textAlign: TextAlign.center,
//                             ),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       } else {
//                         _registerUser(
//                           _usernameController.text,
//                           _passwordController.text,
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.blue[700],
//                       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text('Registrasi'),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => const LoginPages()),
//                         (route) => false,
//                       );
//                     },
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ini yang realtime database

// import 'package:flutter/material.dart';
// import 'package:petcare/login/loginpages.dart';
// import 'package:firebase_database/firebase_database.dart';

// class RegistrasiPages extends StatefulWidget {
//   const RegistrasiPages({super.key});

//   @override
//   State<RegistrasiPages> createState() => _RegistrasiPagesState();
// }

// class _RegistrasiPagesState extends State<RegistrasiPages> {
//   // Controller untuk inputan
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   // Variabel untuk toggle visibility password
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;

//   // Referensi ke Firebase Realtime Database
//   final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("users");

//   // Fungsi untuk memeriksa apakah username sudah terdaftar
//   Future<bool> _isUsernameTaken(String username) async {
//     final snapshot = await _databaseRef.orderByChild('username').equalTo(username).get();
//     return snapshot.exists; // Jika ada data dengan username yang sama, return true
//   }

//   // Fungsi untuk menambahkan data ke Firebase
//   Future<void> _registerUser(String username, String password) async {
//     try {
//       await _databaseRef.push().set({
//         'username': username,
//         'password': password, // Jangan simpan password plaintext dalam aplikasi nyata
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Registrasi berhasil!',
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Navigasi ke halaman login
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPages()),
//         (route) => false,
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Terjadi kesalahan: $error',
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF125587),
//         centerTitle: true,
//         title: const Text(
//           'Registrasi PetCare',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       backgroundColor: const Color(0xFF125587),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: SizedBox(
//                     height: 200,
//                     child: Image.asset(
//                       'assets/images/background.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: "Masukkan Nama (username)",
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   controller: _passwordController,
//                   obscureText: !_isPasswordVisible,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: 'Masukkan password',
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.white54,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   controller: _confirmPasswordController,
//                   obscureText: !_isConfirmPasswordVisible,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: 'Konfirmasi password',
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.white54,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       // Validasi input
//                       if (_usernameController.text.isEmpty ||
//                           _passwordController.text.isEmpty ||
//                           _confirmPasswordController.text.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text(
//                               'Semua kolom harus diisi!',
//                               textAlign: TextAlign.center,
//                             ),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       } else if (_passwordController.text != _confirmPasswordController.text) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text(
//                               'Password dan konfirmasi password tidak cocok!',
//                               textAlign: TextAlign.center,
//                             ),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       } else if (await _isUsernameTaken(_usernameController.text)) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text(
//                               'Username sudah digunakan!',
//                               textAlign: TextAlign.center,
//                             ),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       } else {
//                         _registerUser(
//                           _usernameController.text,
//                           _passwordController.text,
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.blue[700],
//                       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text('Registrasi'),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => const LoginPages()),
//                         (route) => false,
//                       );
//                     },
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// KODE ASLI DIATASE

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcare/login/loginpages.dart';

class RegistrasiPages extends StatefulWidget {
  const RegistrasiPages({super.key});

  @override
  State<RegistrasiPages> createState() => _RegistrasiPagesState();
}

class _RegistrasiPagesState extends State<RegistrasiPages> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  // Fungsi untuk memeriksa apakah username sudah terdaftar
  Future<bool> _isUsernameTaken(String username) async {
    try {
      final snapshot = await _databaseRef
          .child('users')
          .orderByChild('username')
          .equalTo(username)
          .get();
      return snapshot.exists;
    } catch (e) {
      print('Error checking username: $e');
      return false;
    }
  }

  // Fungsi untuk menyimpan userId ke SharedPreferences
  Future<void> _saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  // Fungsi untuk mendaftarkan pengguna
  Future<void> _registerUser(
      String email, String username, String password) async {
    try {
      // Buat pengguna di Firebase Authentication
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String userId = userCredential.user!.uid;

      // Simpan data pengguna ke Realtime Database
      await _databaseRef.child('users').child(userId).set({
        'email': email,
        'username': username,
        'hewan': {},
        'createdAt': ServerValue.timestamp,
      });

      // Simpan userId secara lokal
      await _saveUserId(userId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registrasi berhasil!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Sign out setelah registrasi
      await _auth.signOut();

      // Navigasi ke halaman login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPages()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Password terlalu lemah (minimal 6 karakter)';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email sudah digunakan!';
          break;
        default:
          errorMessage = 'Terjadi kesalahan saat registrasi';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan: $error',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF125587),
        centerTitle: true,
        title: const Text(
          'Registrasi PetCare',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF125587),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF125587),
                    hintText: "Masukkan Email",
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF125587),
                    hintText: "Masukkan Nama (username)",
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF125587),
                    hintText: 'Masukkan password',
                    hintStyle: const TextStyle(color: Colors.white54),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white54,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF125587),
                    hintText: 'Konfirmasi password',
                    hintStyle: const TextStyle(color: Colors.white54),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white54,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_emailController.text.isEmpty ||
                          _usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _confirmPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Semua kolom harus diisi!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password dan konfirmasi password tidak cocok!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (await _isUsernameTaken(
                          _usernameController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Username sudah digunakan!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        _registerUser(
                          _emailController.text,
                          _usernameController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Registrasi'),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPages()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
