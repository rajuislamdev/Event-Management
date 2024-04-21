import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Admin {
  final String name;
  final String email;
  final String phone;
  final String utmid;
  Admin({
    required this.name,
    required this.email,
    required this.phone,
    required this.utmid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'utmid': utmid,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      utmid: map['utmid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) =>
      Admin.fromMap(json.decode(source) as Map<String, dynamic>);
}
