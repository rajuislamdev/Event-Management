import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Student {
  final String? id;
  final String utmid;
  final String name;
  final String email;
  final String phone;
  final String matricNo;
  final String faculty;
  final String program;
  final String semester;
  Student({
    this.id,
    required this.utmid,
    required this.name,
    required this.email,
    required this.phone,
    required this.matricNo,
    required this.faculty,
    required this.program,
    required this.semester,
  });

  Student copyWith({
    String? id,
    String? utmid,
    String? name,
    String? email,
    String? phone,
    String? matricNo,
    String? faculty,
    String? program,
    String? semester,
  }) {
    return Student(
      id: id ?? this.id,
      utmid: utmid ?? this.utmid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      matricNo: matricNo ?? this.matricNo,
      faculty: faculty ?? this.faculty,
      program: program ?? this.program,
      semester: semester ?? this.semester,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'utmid': utmid,
      'name': name,
      'email': email,
      'phone': phone,
      'matricNo': matricNo,
      'faculty': faculty,
      'program': program,
      'semester': semester,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] != null ? map['id'] as String : null,
      utmid: map['utmid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      matricNo: map['matricNo'] as String,
      faculty: map['faculty'] as String,
      program: map['program'] as String,
      semester: map['semester'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
}
