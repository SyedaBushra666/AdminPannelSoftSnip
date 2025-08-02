import 'package:flutter/material.dart';

class Member {
  final String id;
  String firstName;
  String lastName;
  String email;
  String role;
  String project;
  bool isActive;

  Member({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.project,
    this.isActive = true,
  });

  String get fullName => "$firstName $lastName";

  factory Member.fromMap(Map<String, dynamic> map) {
    final parts = (map['name'] ?? '').split(' ');
    return Member(
      id: map['id'] ?? UniqueKey().toString(), // fallback to unique if missing
      firstName: parts.isNotEmpty ? parts.first : '',
      lastName: parts.length > 1 ? parts.sublist(1).join(' ') : '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      project: map['projects'].toString(),
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': fullName,
      'email': email,
      'role': role,
      'projects': project,
      'isActive': isActive,
    };
  }
}
