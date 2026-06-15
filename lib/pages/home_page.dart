import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/student.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar mahasiswa
  late List<Student> _students;

  @override
  void initState() {
    super.initState();
    // Konversi initialStudentsData (List<Map>) menjadi List<Student>
    _students = initialStudentsData
        .map((data) => Student.fromMap(data))
        .toList();
  }

  // ─── Navigasi ke Halaman 2 (Tambah Mahasiswa) ────────────────────────────
  Future<void> _openAddStudentPage() async {
    // Tunggu hasil dari Page 2
    // Teman mengimplementasikan Page 2 dan memanggil Navigator.pop(context, newStudent)
    final result = await Navigator.pushNamed(context, '/add');

    if (result != null && result is Student) {
      setState(() {
        _students.add(result);
      });
    }
  }

  // ─── Navigasi ke Halaman 3 (Profile) ─────────────────────────────────────
  Future<void> _openProfilePage(Student student) async {

    final result = await Navigator.pushNamed(
      context,
      '/profile',
      arguments: {
        'student': student,
        'totalStudents': _students.length,
      },
    );

    if (result != null && result is Student) {
      setState(() {
        _students.removeWhere(
          (s) => s.name == result.name && s.phone == result.phone,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // ── App Bar ────────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Directory',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              '${_students.length} mahasiswa',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),

      // ── Body: GridView 2 kolom ─────────────────────────────────────────────
      body: _students.isEmpty
          ? const Center(
              child: Text(
                'Belum ada mahasiswa.\nTambahkan melalui tombol +',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: _students.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,        // 2 kolom sesuai spesifikasi
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,   // proporsi kartu
                ),
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return _StudentCard(
                    student: student,
                    onTap: () => _openProfilePage(student),
                  );
                },
              ),
            ),

      // ── FAB: buka Halaman 2 ────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddStudentPage,
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        tooltip: 'Tambah Mahasiswa',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ── Widget Kartu Mahasiswa ─────────────────────────────────────────────────────
class _StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const _StudentCard({required this.student, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Foto Avatar ──────────────────────────────────────────────
              CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFFBBDEFB),
                backgroundImage: NetworkImage(student.avatar),
                onBackgroundImageError: (_, __) {},
              ),
              const SizedBox(height: 12),

              // ── Nama Mahasiswa ───────────────────────────────────────────
              Text(
                student.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 6),

              // ── Domisili ─────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 13,
                    color: Color(0xFF1565C0),
                  ),
                  const SizedBox(width: 3),
                  Flexible(
                    child: Text(
                      student.domisili,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}