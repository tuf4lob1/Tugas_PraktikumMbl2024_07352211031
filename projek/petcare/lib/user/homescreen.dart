// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart'; // Import Firebase
// import 'package:petcare/user/jadwalscreen.dart';
// import 'package:petcare/user/lihathewan.dart';
// import 'package:petcare/user/produk.dart';
// // ignore: unused_import
// import 'package:petcare/user/profilescreen.dart';
// import 'package:petcare/user/tambahhewan.dart';
// import 'package:petcare/login/loginpages.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 1; // Halaman Home sebagai default
//   String username = "";
//   String userId = "";

//   // Database reference
//   final DatabaseReference _usersRef = FirebaseDatabase.instance.ref("users");

//   @override
//   void initState() {
//     super.initState();
//     _getUserData();
//   }

//   // Mengambil data user dari Firebase
//  Future<void> _getUserData() async {
//   final snapshot = await _usersRef.child('OG4VEKWdH7WLzyNpnxm').get();
//   if (snapshot.exists) {
//     final data = snapshot.value as Map<String, dynamic>?; // Cast to Map
//     setState(() {
//       username = data?['username'];
//       userId = data?['password'];
//     });
//   } else {
//     print('User not found');
//   }
// }

//   // Daftar halaman
//   static final List<Widget> _pages = <Widget>[
//     const Jadwalscreen(), // Halaman Jadwal
//     const HomeScreenContent(), // Isi utama halaman Home
//     // Gunakan data yang telah diambil untuk ProfileScreen
//     // ProfileScreen diupdate dengan data user yang valid
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Ubah halaman berdasarkan index yang dipilih
//     });
//   }

//   // Fungsi untuk menampilkan konfirmasi logout
//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Konfirmasi Logout'),
//           content: const Text('Apakah Anda yakin ingin logout?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Menutup dialog
//               },
//               child: const Text('Batal'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigasi ke halaman login dan hapus semua route sebelumnya
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPages()),
//                   (route) => false,
//                 );
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PetCare', style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF125587),
//         centerTitle: true,
//       ),
//       drawer: _selectedIndex == 1
//           ? Drawer(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   DrawerHeader(
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF125587),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.asset(
//                           'assets/images/HomeScreen.png',
//                           width: 70,
//                           height: 70,
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'PetCare',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.close),
//                     title: const Text('Tutup Sidebar'),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const Divider(),
//                   ListTile(
//                     leading: const Icon(Icons.exit_to_app),
//                     title: const Text('Logout'),
//                     onTap: _showLogoutDialog,
//                   ),
//                 ],
//               ),
//             )
//           : null,
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.note_alt),
//             label: 'Jadwal',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomeScreenContent extends StatelessWidget {
//   const HomeScreenContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(10.0),
//         color: const Color(0xFF125587),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Selamat Datang Di',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     'PetCare',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//             Image.asset(
//               'assets/images/HomeScreen.png', 
//               height: 250,
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const TambahHewan()));
//               },
//               icon: const Icon(Icons.add),
//               label: const Text(
//                 'Tambah Hewan Peliharaan',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const LihatHewan()));
//               },
//               icon: const Icon(Icons.remove_red_eye),
//               label: const Text(
//                 'Melihat Data Hewan Peliharaan',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ProdukPages()));
//               },
//               icon: const Icon(Icons.card_travel),
//               label: const Text(
//                 'Lihat Produk Yang Ditawarkan',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
























//jadi





// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart'; // Import Firebase
// import 'package:petcare/user/jadwalscreen.dart';
// import 'package:petcare/user/lihathewan.dart';
// import 'package:petcare/user/produk.dart';
// // ignore: unused_import
// import 'package:petcare/user/profilescreen.dart';
// import 'package:petcare/user/tambahhewan.dart';
// import 'package:petcare/login/loginpages.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 1; // Halaman Home sebagai default
//   String username = "";
//   String userId = "";

//   // Database reference
//   final DatabaseReference _usersRef = FirebaseDatabase.instance.ref("users");

//   @override
//   void initState() {
//     super.initState();
//     _getUserData();
//   }

//   // Mengambil data user dari Firebase
//   Future<void> _getUserData() async {
//     final snapshot = await _usersRef.child('OG4VEKWdH7WLzyNpnxm').get();
//     if (snapshot.exists) {
//       final data = snapshot.value as Map<String, dynamic>?; // Cast to Map
//       setState(() {
//         username = data?['username'] ?? ''; // Memastikan username ada
//         userId = data?['password'] ?? ''; // Memastikan password ada
//       });
//     } else {
//       print('User not found');
//     }
//   }

//   // Daftar halaman
//   static final List<Widget> _pages = <Widget>[
//     const Jadwalscreen(), // Halaman Jadwal
//     const HomeScreenContent(), // Isi utama halaman Home
//     // Gunakan data yang telah diambil untuk ProfileScreen
//     ProfileScreen(username: '', userId: ''), // Update ProfileScreen dengan data yang valid
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Ubah halaman berdasarkan index yang dipilih
//     });
//   }

//   // Fungsi untuk menampilkan konfirmasi logout
//   void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Konfirmasi Logout'),
//           content: const Text('Apakah Anda yakin ingin logout?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Menutup dialog
//               },
//               child: const Text('Batal'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigasi ke halaman login dan hapus semua route sebelumnya
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPages()),
//                   (route) => false,
//                 );
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PetCare', style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF125587),
//         centerTitle: true,
//       ),
//       drawer: _selectedIndex == 1
//           ? Drawer(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   DrawerHeader(
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF125587),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.asset(
//                           'assets/images/HomeScreen.png',
//                           width: 70,
//                           height: 70,
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'PetCare',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.close),
//                     title: const Text('Tutup Sidebar'),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const Divider(),
//                   ListTile(
//                     leading: const Icon(Icons.exit_to_app),
//                     title: const Text('Logout'),
//                     onTap: _showLogoutDialog,
//                   ),
//                 ],
//               ),
//             )
//           : null,
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.note_alt),
//             label: 'Jadwal',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomeScreenContent extends StatelessWidget {
//   const HomeScreenContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(10.0),
//         color: const Color(0xFF125587),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Selamat Datang Di',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     'PetCare',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//             Image.asset(
//               'assets/images/HomeScreen.png', 
//               height: 250,
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const TambahHewan()));
//               },
//               icon: const Icon(Icons.add),
//               label: const Text(
//                 'Tambah Hewan Peliharaan',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const LihatHewan()));
//               },
//               icon: const Icon(Icons.remove_red_eye),
//               label: const Text(
//                 'Melihat Data Hewan Peliharaan',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ProdukPages()));
//               },
//               icon: const Icon(Icons.card_travel),
//               label: const Text(
//                 'Lihat Produk Yang Ditawarkan',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



























import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase
import 'package:petcare/user/jadwalscreen.dart';
import 'package:petcare/user/lihathewan.dart';
import 'package:petcare/user/produk.dart';
// ignore: unused_import
import 'package:petcare/user/profilescreen.dart';
import 'package:petcare/user/tambahhewan.dart';
import 'package:petcare/login/loginpages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Halaman Home sebagai default
  String username = "";
  String userId = "";

  // Database reference
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref("users");

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // Mengambil data user dari Firebase
  Future<void> _getUserData() async {
    final snapshot = await _usersRef.child('OG4VEKWdH7WLzyNpnxm').get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<String, dynamic>?; // Cast to Map
      setState(() {
        username = data?['username'] ?? ''; // Memastikan username ada
        userId = data?['password'] ?? ''; // Memastikan password ada
      });
    } else {
      print('User not found');
    }
  }

  // Daftar halaman
  static final List<Widget> _pages = <Widget>[
    const Jadwalscreen(), // Halaman Jadwal
    const HomeScreenContent(), // Isi utama halaman Home
    // Gunakan data yang telah diambil untuk ProfileScreen
    ProfileScreen(username: '', userId: ''), // Update ProfileScreen dengan data yang valid
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Ubah halaman berdasarkan index yang dipilih
    });
  }

  // Fungsi untuk menampilkan konfirmasi logout
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman login dan hapus semua route sebelumnya
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPages()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetCare', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF125587),
        centerTitle: true,
      ),
      drawer: _selectedIndex == 1
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFF125587),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/HomeScreen.png',
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'PetCare',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.close),
                    title: const Text('Tutup Sidebar'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: _showLogoutDialog,
                  ),
                ],
              ),
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: const Color(0xFF125587),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Selamat Datang Di',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'PetCare',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/HomeScreen.png', 
              height: 250,
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TambahHewan()));
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Tambah Hewan Peliharaan',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LihatHewan()));
              },
              icon: const Icon(Icons.remove_red_eye),
              label: const Text(
                'Melihat Data Hewan Peliharaan',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProdukPages()));
              },
              icon: const Icon(Icons.card_travel),
              label: const Text(
                'Lihat Produk Yang Ditawarkan',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
