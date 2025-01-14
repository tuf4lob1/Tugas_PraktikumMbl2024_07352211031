// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class ProfileScreen extends StatefulWidget {
//   final String userId; // ID unik untuk pengguna saat ini

//   const ProfileScreen({super.key, required this.userId, required String username});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController nicknameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   late DatabaseReference profileRef;
//   late DatabaseReference userRef;

//   @override
//   void initState() {
//     super.initState();
//     // Referensi ke user dan profile
//     userRef = FirebaseDatabase.instance.ref("users/${widget.userId}");
//     _loadProfileData();
//   }

//   // Memuat data profil dari database
//   Future<void> _loadProfileData() async {
//     try {
//       final userSnapshot = await userRef.get();
//       if (userSnapshot.exists) {
//         final userData = Map<String, dynamic>.from(userSnapshot.value as Map);
//         final profileId = userData["profileId"];

//         if (profileId != null) {
//           final profileIdString = profileId.toString(); // Pastikan profileId adalah string

//           profileRef = FirebaseDatabase.instance.ref("profiles/$profileIdString");

//           // Mendengarkan perubahan data profil
//           profileRef.onValue.listen((event) {
//             if (event.snapshot.exists) {
//               final data = Map<String, dynamic>.from(event.snapshot.value as Map);

//               setState(() {
//                 nameController.text = data["name"] ?? "";
//                 nicknameController.text = data["nickname"] ?? "";
//                 phoneController.text = data["phone"] ?? "";
//               });
//             }
//           });

//           // Memuat data profil untuk pertama kali
//           final snapshot = await profileRef.get();
//           if (snapshot.exists) {
//             final data = Map<String, dynamic>.from(snapshot.value as Map);

//             setState(() {
//               nameController.text = data["name"] ?? "";
//               nicknameController.text = data["nickname"] ?? "";
//               phoneController.text = data["phone"] ?? "";
//             });
//           }
//         } else {
//           print("Tidak ditemukan profileId pada user");
//         }
//       } else {
//         print("Pengguna tidak ditemukan");
//       }
//     } catch (e) {
//       print("Terjadi kesalahan: $e");
//     }
//   }

//   // Menyimpan atau memperbarui data profil
//   Future<void> _saveOrUpdateProfile() async {
//     try {
//       // Generate profileId baru atau gunakan yang sudah ada
//       final newProfileId = DateTime.now().millisecondsSinceEpoch.toString();

//       // Simpan data profil di node profiles
//       await FirebaseDatabase.instance.ref("profiles/$newProfileId").set({
//         "name": nameController.text,
//         "nickname": nicknameController.text,
//         "phone": phoneController.text,
//       });

//       // Update user dengan profileId yang baru
//       await userRef.update({
//         "profileId": newProfileId,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Profil berhasil disimpan atau diperbarui'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Terjadi kesalahan: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color(0xFF125587),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const CircleAvatar(
//               radius: 60,
//               backgroundColor: Colors.white,
//               child: Icon(
//                 Icons.person,
//                 size: 60,
//                 color: Color(0xFF125587),
//               ),
//             ),
//             const SizedBox(height: 15),
//             const Text(
//               'Tambahkan Profil Anda',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               margin: const EdgeInsets.symmetric(horizontal: 25),
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextField('Nama Lengkap', nameController),
//                   const SizedBox(height: 12),
//                   _buildTextField('Nama Panggilan', nicknameController),
//                   const SizedBox(height: 12),
//                   _buildTextField('Nomor Telepon', phoneController),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _saveOrUpdateProfile,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: const Color(0xFF125587),
//                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               icon: const Icon(Icons.save, size: 20),
//               label: const Text('Simpan Profil'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 5),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }






































import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required String username, required String userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? userId;
  String? username;
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserDataAndProfile();
  }

  Future<void> _loadUserDataAndProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Get userId from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId');

      if (userId != null) {
        // Get user data reference
        final userRef = _databaseRef.child('users').child(userId!);
        
        // Get user data snapshot
        final DataSnapshot userSnapshot = await userRef.get();
        
        if (userSnapshot.exists && userSnapshot.value != null) {
          final userData = Map<String, dynamic>.from(userSnapshot.value as Map);
          
          setState(() {
            username = userData['username'] as String?;
            
            // Check if profile data exists and load it
            if (userData.containsKey('profile')) {
              final profileData = Map<String, dynamic>.from(userData['profile'] as Map);
              nameController.text = profileData['name'] ?? '';
              nicknameController.text = profileData['nickname'] ?? '';
              phoneController.text = profileData['phone'] ?? '';
            }
          });
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Sesi tidak valid. Silakan login kembali.',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error loading profile: $e',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sesi tidak valid. Silakan login kembali.',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate input fields
    if (nameController.text.trim().isEmpty ||
        nicknameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Semua field harus diisi!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Save profile data directly under the user's node
      await _databaseRef.child('users').child(userId!).update({
        'profile': {
          'name': nameController.text.trim(),
          'nickname': nicknameController.text.trim(),
          'phone': phoneController.text.trim(),
          'updatedAt': ServerValue.timestamp,
        }
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Profil berhasil disimpan',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
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
  }

  @override
  void dispose() {
    nameController.dispose();
    nicknameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF125587),
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF125587),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF125587),
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (username != null)
                      Text(
                        '@$username',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField('Nama Lengkap', nameController),
                          const SizedBox(height: 12),
                          _buildTextField('Nama Panggilan', nicknameController),
                          const SizedBox(height: 12),
                          _buildTextField('Nomor Telepon', phoneController),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF125587),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.save, size: 20),
                      label: const Text('Simpan Profil'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: const TextStyle(
            color: Color(0xFF125587),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}