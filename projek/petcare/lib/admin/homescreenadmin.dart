import 'package:flutter/material.dart';
import 'package:petcare/admin/datahewan.dart';
import 'package:petcare/admin/datauser.dart';
import 'package:petcare/admin/produkpage.dart';
import 'package:petcare/admin/profil_admin.dart';
import 'package:petcare/login/loginpages.dart';
import 'package:petcare/admin/jadwal.dart'; // Import halaman jadwal

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  int _currentIndex = 0; // Indeks halaman aktif

  final List<Widget> _pages = [
    const HomePage(),
    const DataUserPage(userId: '',),
    const DataHewanPage(),
    const ProdukPagesAdmin(),
    const JadwalAdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF125587),
      appBar: _currentIndex == 0
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color(0xFF125587),
            )
          : null,
      drawer: _currentIndex == 0
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  AssetImage('assets/images/HomeScreen.png'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Admin PetCare',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profil'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileAdminPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Keluar'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text(
                                'Apakah Anda yakin ingin keluar?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPages()),
                                    (route) => false,
                                  );
                                },
                                child: const Text('Keluar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Data User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Data Hewan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Jadwal',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF125587),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white),
            ),
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang Di',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Home admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'PetCare',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/HomeScreen.png'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: screenWidth > 600 ? 3 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: [
              _buildMenuButton(
                context,
                title: 'Data User',
                color: Colors.yellow,
                icon: Icons.person,
                page: const DataUserPage(userId: '',),
              ),
              _buildMenuButton(
                context,
                title: 'Data Hewan',
                color: Colors.orange,
                icon: Icons.pets,
                page: const DataHewanPage(),
              ),
              _buildMenuButton(
                context,
                title: 'Produk',
                color: Colors.green,
                icon: Icons.shopping_cart,
                page: const ProdukPagesAdmin(),
              ),
              _buildMenuButton(
                context,
                title: 'Jadwal',
                color: Colors.lightBlue,
                icon: Icons.schedule,
                page: const JadwalAdminPage(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required Color color,
    required IconData icon,
    required Widget page,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
