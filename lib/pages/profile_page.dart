import 'package:flutter/material.dart';
import '../models/student.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Data diterima dari Halaman 1 melalui arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Student student = args['student'];
    final int totalStudents = args['totalStudents'];

    // Batas minimum daftar: Nonaktifkan (disable) jika mahasiswa <= 3
    final bool isDeleteEnabled = totalStudents > 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text(
          'Student Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        // 3. Mekanisme kembali ke Halaman 1 secara default ada pada AppBar (tombol panah)
        // Tombol bawaan ini akan memanggil Navigator.pop(context, null)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            // 2. Tampilkan Foto Avatar
            CircleAvatar(
              radius: 70,
              backgroundColor: const Color(0xFFDEE8FF),
              backgroundImage: NetworkImage(student.avatar),
              onBackgroundImageError: (_, __) {},
            ),
            const SizedBox(height: 24),

            // 2. Tampilkan Nama
            Text(
              student.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111C2D),
              ),
            ),
            const SizedBox(height: 8),

            // 2. Tampilkan Domisili
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Color(0xFF1565C0), size: 20),
                const SizedBox(width: 6),
                Text(
                  student.domisili,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF434655),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 2. Tampilkan Nomor HP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone, color: Color(0xFF1565C0), size: 20),
                const SizedBox(width: 6),
                Text(
                  student.phone,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF434655),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 60),

            // 4. Tombol "Hapus Akun Ini"
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                // Jika isDeleteEnabled false, onPressed menjadi null (tombol otomatis disabled/abu-abu)
                onPressed: isDeleteEnabled
                    ? () {
                        // Mengirimkan object student kembali ke Halaman 1 untuk dihapus
                        Navigator.pop(context, student);
                      }
                    : null,
                icon: const Icon(Icons.delete_outline),
                label: const Text(
                  'Hapus Akun Ini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFC3C6D7),
                  disabledForegroundColor: const Color(0xFF434655).withOpacity(0.5),
                  elevation: isDeleteEnabled ? 2 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Pesan informatif jika tombol disable (opsional, tapi bagus untuk UX)
            if (!isDeleteEnabled) ...[
              const SizedBox(height: 12),
              const Text(
                'Tidak dapat menghapus data.\nJumlah mahasiswa minimum adalah 3.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
