import 'package:flutter/material.dart';

class BPJSScreen extends StatelessWidget {
  const BPJSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar BPJS dengan kode angka
    final List<Map<String, String>> daftarBPJS = [
      {'nama': 'BPJS Kesehatan', 'kode': '201'},
      {
        'nama': 'BPJS Ketenagakerjaan - Jaminan Kecelakaan Kerja',
        'kode': '202'
      },
      {'nama': 'BPJS Ketenagakerjaan - Jaminan Kematian', 'kode': '203'},
      {'nama': 'BPJS Ketenagakerjaan - Jaminan Hari Tua', 'kode': '204'},
      {'nama': 'BPJS Ketenagakerjaan - Jaminan Pensiun', 'kode': '205'},
      {
        'nama': 'BPJS Ketenagakerjaan - Jaminan Kehilangan Pekerjaan',
        'kode': '206'
      },
      {'nama': 'BPJS Kesehatan - Peserta Mandiri', 'kode': '207'},
      {
        'nama': 'BPJS Kesehatan - Peserta Penerima Bantuan Iuran (PBI)',
        'kode': '208'
      },
      {
        'nama': 'BPJS Kesehatan - Peserta Bukan Penerima Upah (BPU)',
        'kode': '209'
      },
      {
        'nama': 'BPJS Kesehatan - Peserta Pekerja Penerima Upah (PPU)',
        'kode': '210'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar BPJS'),
        backgroundColor: Colors.blue,
      ),
      body: Scrollbar(
        thickness: 6,
        radius: const Radius.circular(10),
        child: ListView.builder(
          itemCount: daftarBPJS.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(daftarBPJS[index]['nama']!),
                subtitle: Text('Kode: ${daftarBPJS[index]['kode']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}