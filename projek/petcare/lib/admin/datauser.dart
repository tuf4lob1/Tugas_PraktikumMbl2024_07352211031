// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class DataUserPage extends StatefulWidget {
//   const DataUserPage({super.key, required String userId});

//   @override
//   State<DataUserPage> createState() => _DataUserPageState();
// }

// class _DataUserPageState extends State<DataUserPage> {
//   final DatabaseReference _profileRef = FirebaseDatabase.instance
//       .ref("users")
//       .child("profile"); // Referensi ke "profile"
//   List<Map<String, String>> _profileList = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   void _loadData() {
//     // Listener untuk mengambil data secara real-time
//     _profileRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;

//       if (data != null) {
//         setState(() {
//           _profileList = [
//             {
//               'nama': data['name'] ?? 'Tidak ada nama',
//               'nickname': data['nickname'] ?? 'Tidak ada nama panggilan',
//               'no_telp': data['phone'] ?? 'Tidak ada no. telepon',
//             }
//           ];
//         });
//       }
//     });
//   }

//   void _deleteProfile(int index) {
//     // Hapus profil dari database berdasarkan index
//     final userKey = _profileRef.key;
//     if (userKey != null) {
//       _profileRef.remove();
//       setState(() {
//         _profileList.removeAt(index);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF125587),
//         title:
//             const Text('Data Pengguna', style: TextStyle(color: Colors.white)),
//       ),
//       body: _buildProfileList(),
//     );
//   }

//   Widget _buildProfileList() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF125587), Colors.blue],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: ListView.builder(
//         itemCount: _profileList.length,
//         itemBuilder: (context, index) {
//           return _UserCard(
//             pengguna: _profileList[index],
//             onDelete: () => _confirmDelete(context, index),
//           );
//         },
//       ),
//     );
//   }

//   void _confirmDelete(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Hapus Data'),
//         content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(ctx).pop(),
//             child: const Text('Batal'),
//           ),
//           TextButton(
//             onPressed: () {
//               _deleteProfile(index);
//               Navigator.of(ctx).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Data berhasil dihapus'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//             child: const Text(
//               'Hapus',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _UserCard extends StatelessWidget {
//   final Map<String, String> pengguna;
//   final VoidCallback onDelete;

//   const _UserCard({
//     required this.pengguna,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 6,
//       shadowColor: Colors.black45,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(20.0),
//         leading: CircleAvatar(
//           backgroundColor: Colors.blueAccent,
//           radius: 30,
//           child: Text(
//             pengguna['nama']![0].toUpperCase(),
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ),
//         title: Text(
//           pengguna['nama']!,
//           style: const TextStyle(
//             color: Colors.blue,
//             fontSize: 22,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 5.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildUserInfoRow(
//                   Icons.person, 'Nama Panggilan', pengguna['nickname']!),
//               const SizedBox(height: 5),
//               _buildUserInfoRow(Icons.phone, 'No. Tlp', pengguna['no_telp']!),
//             ],
//           ),
//         ),
//         trailing: IconButton(
//           icon: const Icon(Icons.delete, color: Colors.red),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }

//   Widget _buildUserInfoRow(IconData icon, String label, String value) {
//     return Row(
//       children: [
//         Icon(icon, size: 14, color: Colors.black54),
//         const SizedBox(width: 5),
//         Flexible(
//           child: Text(
//             '$label: $value',
//             style: const TextStyle(
//                 color: Colors.black54, fontSize: 11), // Ukuran font lebih kecil
//             overflow: TextOverflow.ellipsis, // Menangani teks panjang
//           ),
//         ),
//       ],
//     );
//   }
// }




















import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DataUserPage extends StatefulWidget {
  const DataUserPage({super.key, required String userId});

  @override
  State<DataUserPage> createState() => _DataUserPageState();
}

class _DataUserPageState extends State<DataUserPage> {
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref("users");
  List<Map<String, String>> _usersList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Listener untuk mengambil data secara real-time
    _usersRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        final List<Map<String, String>> loadedUsers = [];

        data.forEach((key, value) {
          if (value['profile'] != null) {
            final profile = Map<String, dynamic>.from(value['profile'] as Map);
            loadedUsers.add({
              'nama': profile['name'] ?? 'Tidak ada nama',
              'nickname': profile['nickname'] ?? 'Tidak ada nama panggilan',
              'no_telp': profile['phone'] ?? 'Tidak ada no. telepon',
            });
          }
        });

        setState(() {
          _usersList = loadedUsers;
        });
      }
    });
  }

  void _deleteUser(String userId) {
    // Hapus data pengguna berdasarkan userId
    _usersRef.child(userId).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF125587),
        title: const Text('Data Pengguna', style: TextStyle(color: Colors.white)),
      ),
      body: _buildUsersList(),
    );
  }

  Widget _buildUsersList() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF125587), Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _usersList.length,
        itemBuilder: (context, index) {
          return _UserCard(
            pengguna: _usersList[index],
            onDelete: () => _confirmDelete(context, index),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Data'),
        content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _deleteUser(_usersList[index]['userId']!);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data berhasil dihapus'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final Map<String, String> pengguna;
  final VoidCallback onDelete;

  const _UserCard({
    required this.pengguna,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black45,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20.0),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          radius: 30,
          child: Text(
            pengguna['nama']![0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        title: Text(
          pengguna['nama']!,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoRow(
                  Icons.person, 'Nama Panggilan', pengguna['nickname']!),
              const SizedBox(height: 5),
              _buildUserInfoRow(Icons.phone, 'No. Tlp', pengguna['no_telp']!),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.black54),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            '$label: $value',
            style: const TextStyle(
                color: Colors.black54, fontSize: 11),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
