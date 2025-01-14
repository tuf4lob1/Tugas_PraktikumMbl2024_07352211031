// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class LupapaswordPages extends StatefulWidget {
//   const LupapaswordPages({super.key});

//   @override
//   State<LupapaswordPages> createState() => _LupapaswordPagesState();
// }

// class _LupapaswordPagesState extends State<LupapaswordPages> {
//   // Controller untuk inputan
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   // State untuk mengontrol visibility password
//   bool _isNewPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;

//   // Referensi ke Firebase Realtime Database
//   final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("users");

//   // Fungsi untuk memperbarui password
//   Future<void> _updatePassword(String username, String newPassword) async {
//     try {
//       // Cari user berdasarkan username
//       final snapshot = await _databaseRef.orderByChild('username').equalTo(username).once();
//       if (snapshot.snapshot.exists) {
//         // Perbarui password untuk user yang ditemukan
//         final userKey = snapshot.snapshot.children.first.key;
//         await _databaseRef.child(userKey!).update({'password': newPassword});

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'Password berhasil diubah!',
//               textAlign: TextAlign.center,
//             ),
//             backgroundColor: Colors.green,
//           ),
//         );

//         // Kembali ke halaman login atau sebelumnya
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'Username tidak ditemukan!',
//               textAlign: TextAlign.center,
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
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
//           'Lupa Password',
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
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   style: const TextStyle(color: Colors.white),
//                   controller: _newPasswordController,
//                   obscureText: !_isNewPasswordVisible,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: 'Masukkan password baru',
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.white54,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isNewPasswordVisible = !_isNewPasswordVisible;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
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
//                     hintText: 'Konfirmasi password baru',
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
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_usernameController.text.isEmpty ||
//                           _newPasswordController.text.isEmpty ||
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
//                       } else if (_newPasswordController.text != _confirmPasswordController.text) {
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
//                         _updatePassword(
//                           _usernameController.text,
//                           _newPasswordController.text,
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
//                     child: const Text('Konfirmasi'),
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LupapaswordPages extends StatefulWidget {
  const LupapaswordPages({super.key});

  @override
  State<LupapaswordPages> createState() => _LupapaswordPagesState();
}

class _LupapaswordPagesState extends State<LupapaswordPages> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk mengirim email reset password
  Future<void> _sendResetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email reset password telah dikirim. Periksa email Anda.',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      String pesanError = 'Terjadi kesalahan';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            pesanError = 'Email tidak ditemukan';
            break;
          case 'invalid-email':
            pesanError = 'Format email tidak valid';
            break;
          default:
            pesanError = 'Terjadi kesalahan: ${e.message}';
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            pesanError,
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
          'Lupa Password',
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
                    hintText: "Masukkan Email Anda",
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
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Masukkan email terlebih dahulu!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      await _sendResetPasswordEmail(
                          _emailController.text.trim());
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
                    child: const Text('Kirim Email Reset Password'),
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
