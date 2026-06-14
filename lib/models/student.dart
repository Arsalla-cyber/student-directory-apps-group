class Student {
  final String name;
  final String avatar;
  final String domisili;
  final String phone;

  Student({
    required this.name,
    required this.avatar,
    required this.domisili,
    required this.phone,
  });

  // Helper: buat Student dari Map (dipakai saat load initialStudentsData)
  factory Student.fromMap(Map<String, String> map) {
    return Student(
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      domisili: map['domisili'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}