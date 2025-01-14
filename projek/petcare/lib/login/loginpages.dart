// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:petcare/admin/homescreenadmin.dart';
// import 'package:petcare/login/registrasipages.dart';
// // ignore: unused_import
// import 'package:petcare/user/homescreen.dart';
// import 'package:petcare/login/lupapasword.dart'; // Import halaman lupa password

// class LoginPages extends StatefulWidget {
//   const LoginPages({super.key});

//   @override
//   State<LoginPages> createState() => _LoginPagesState();
// }

// class _LoginPagesState extends State<LoginPages> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final String _adminUsername = "admin";
//   final String _adminPassword = "admin123";
//   final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("users");
//   bool _isPasswordVisible = false;

//   Future<void> _loginUser(String username, String password) async {
//     if (username == _adminUsername && password == _adminPassword) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreenAdmin()),
//         (route) => false,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Login sebagai admin berhasil'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       try {
//         final snapshot = await _databaseRef.get();
//         if (snapshot.exists) {
//           Map<String, dynamic> users = Map<String, dynamic>.from(snapshot.value as Map);
//           bool userFound = false;

//           users.forEach((key, value) {
//             if (value['username'] == username && value['password'] == password) {
//               userFound = true;
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => const HomeScreen()),
//                 (route) => false,
//               );
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Login berhasil'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             }
//           });

//           if (!userFound) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Username atau Password salah!'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Database kosong!'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Terjadi kesalahan: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   void _navigateToForgotPassword() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const LupapaswordPages()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF125587),
//         centerTitle: true,
//         title: const Text(
//           'Login PetCare',
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
//                 const Text(
//                   'Masukkan Username',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 TextField(
//                   controller: _usernameController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: 'Username',
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
//                 const Text(
//                   'Masukkan Password',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: !_isPasswordVisible,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFF125587),
//                     hintText: 'Password',
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
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: _navigateToForgotPassword,
//                       child: const Text(
//                         'Lupa Password?',
//                         style: TextStyle(
//                           color: Colors.white,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _loginUser(
//                         _usernameController.text.trim(),
//                         _passwordController.text.trim(),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.blue[700],
//                       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text('Login'),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => const RegistrasiPages()),
//                         (route) => false,
//                       );
//                     },
//                     child: const Text(
//                       'Registrasi',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcare/login/registrasipages.dart';
import 'package:petcare/user/homescreen.dart';
import 'package:petcare/admin/homescreenadmin.dart';
import 'package:petcare/login/lupapasword.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;

  // Admin credentials
  final String _adminEmail = "admin@gmail.com";
  final String _adminPassword = "admin123";

  // Save userId to SharedPreferences
  Future<void> _saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<void> _loginUser(String email, String password) async {
    try {
      // Check if the login is for admin
      if (email == _adminEmail && password == _adminPassword) {
        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenAdmin()),
          (route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Login sebagai admin berhasil',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );
        return;
      }

      // Regular user login using Firebase
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save the user ID
      await _saveUserId(userCredential.user!.uid);

      if (!mounted) return;

      // Navigate to home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login berhasil',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Email tidak ditemukan';
          break;
        case 'wrong-password':
          errorMessage = 'Password salah';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid';
          break;
        default:
          errorMessage = 'Terjadi kesalahan saat login';
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
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan: $e',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LupapaswordPages()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF125587),
        centerTitle: true,
        title: const Text(
          'Login PetCare',
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
                const Text(
                  'Masukkan Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF125587),
                    hintText: 'Email',
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
                const Text(
                  'Masukkan Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF125587),
                    hintText: 'Password',
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _navigateToForgotPassword,
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Email dan password harus diisi!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Format email tidak valid!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      _loginUser(email, password);
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
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrasiPages()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Registrasi',
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
