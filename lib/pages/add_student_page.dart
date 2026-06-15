import 'dart:math';
import 'package:flutter/material.dart';
import '../models/student.dart';
import '../data/app_data.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  late String selectedAvatar;
  String? selectedDomisili;
  bool isAgreed = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Warna diambil dari desain Stitch AI
  static const Color primaryColor = Color(0xFF004AC6);
  static const Color surfaceContainerLow = Color(0xFFF0F3FF);
  static const Color outlineVariant = Color(0xFFC3C6D7);
  static const Color onSurfaceVariant = Color(0xFF434655);
  static const Color onSurface = Color(0xFF111C2D);

  @override
  void initState() {
    super.initState();
    // Avatar dipilih acak saat halaman dibuka
    selectedAvatar = avatarList[Random().nextInt(avatarList.length)];
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newStudent = Student(
        name: nameController.text.trim(),
        avatar: selectedAvatar,
        domisili: selectedDomisili!,
        phone: phoneController.text.trim(),
      );
      Navigator.pop(context, newStudent);
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
      filled: true,
      fillColor: surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9FF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Student',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            children: [
              // Avatar Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: const Color(0xFFDEE8FF),
                      backgroundImage: NetworkImage(selectedAvatar),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Random avatar assigned',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Name Field
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: onSurface,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: nameController,
                style: const TextStyle(fontSize: 16, color: onSurface),
                decoration: _inputDecoration("Enter student's full name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Domicile Dropdown
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Domicile',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: onSurface,
                    ),
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedDomisili,
                icon: const Icon(Icons.expand_more, color: Color(0xFF737686)),
                style: const TextStyle(fontSize: 16, color: onSurface),
                decoration: _inputDecoration('Select a city'),
                hint: Text(
                  'Select a city',
                  style: TextStyle(color: Colors.black.withOpacity(0.4)),
                ),
                items: domisiliList.map((domisili) {
                  return DropdownMenuItem(
                    value: domisili,
                    child: Text(domisili),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDomisili = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Domisili wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Phone Number Field
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: onSurface,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 16, color: onSurface),
                decoration: _inputDecoration('+62 812-3456-7890'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Declaration Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: isAgreed,
                      activeColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(
                        color: outlineVariant,
                        width: 2,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isAgreed = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'I declare that the data I entered is correct',
                        style: TextStyle(
                          fontSize: 14,
                          color: onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Bottom Action - Submit Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        color: const Color(0xFFF9F9FF).withOpacity(0.8),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: isAgreed ? _submit : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isAgreed ? primaryColor : outlineVariant,
              foregroundColor:
              isAgreed ? Colors.white : onSurfaceVariant.withOpacity(0.5),
              disabledBackgroundColor: outlineVariant,
              disabledForegroundColor: onSurfaceVariant.withOpacity(0.5),
              elevation: isAgreed ? 4 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}