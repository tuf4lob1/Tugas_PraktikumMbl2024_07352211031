import 'package:flutter/material.dart';

class LayananScreen extends StatelessWidget {
  const LayananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LayananContent(),
    );
  }
}

class _LayananContent extends StatelessWidget {
  const _LayananContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF125587), // Latar belakang dengan warna solid
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          _LayananCard(),
        ],
      ),
    );
  }
}

class _LayananCard extends StatelessWidget {
  const _LayananCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _JadwalHeader(),
              _JadwalDetail(),
              _ConfirmationText(),
              _ConfirmationButton(),
              _BackButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _JadwalHeader extends StatelessWidget {
  const _JadwalHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.calendar_today,
          color: Color(0xFF125587),
        ),
        SizedBox(width: 8),
        Text(
          'Jadwal Konsultasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _JadwalDetail extends StatelessWidget {
  const _JadwalDetail();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 8),
        Text(
          '5 Desember 2024', // Tanggal tetap atau bisa dinamis sesuai kebutuhan
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        SizedBox(height: 8),
        Text(
          'Jam: 14:00', // Anda bisa mengganti jam sesuai kebutuhan
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}

class _ConfirmationText extends StatelessWidget {
  const _ConfirmationText();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Apakah Anda yakin ingin memilih jadwal ini?', // Deskripsi
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _ConfirmationButton extends StatelessWidget {
  const _ConfirmationButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Layanan berhasil dikonfirmasi!'),
            backgroundColor: Colors.green,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF125587),
      ),
      child: const Center(
        child: Text(
          'Konfirmasi',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF125587),
      ),
      child: const Center(
        child: Text(
          'Kembali',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
