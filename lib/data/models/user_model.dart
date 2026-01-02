import 'skill_model.dart';
import 'service_model.dart';

class User {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final List<Skill> skills;
  final DateTime createdAt;
  final List<CustomRole> customRoles;
  final String? matricule;
  final String? phoneNumber;
  final String? address;
  final DateTime? birthDate;
  final String? birthLocation;
  final Gender? gender;
  final String? profileImage;
  final Service? service;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.skills,
    required this.createdAt,
    this.customRoles = const [],
    this.matricule,
    this.phoneNumber,
    this.address,
    this.birthDate,
    this.birthLocation,
    this.gender,
    this.profileImage,
    this.service,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
    List<Skill>? skills,
    DateTime? createdAt,
    List<CustomRole>? customRoles,
    String? matricule,
    String? phoneNumber,
    String? address,
    DateTime? birthDate,
    String? birthLocation,
    Gender? gender,
    String? profileImage,
    Service? service,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      skills: skills ?? this.skills,
      createdAt: createdAt ?? this.createdAt,
      customRoles: customRoles ?? this.customRoles,
      matricule: matricule ?? this.matricule,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      birthLocation: birthLocation ?? this.birthLocation,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
      service: service ?? this.service,
    );
  }
}

enum UserRole { admin, projectManager, member }

enum Gender { male, female }

// Statistiques de l'utilisateur
class UserStats {
  final int projectsAsHead;
  final int finishedTasks;
  final int ongoingTasks;
  final double completionRate;

  UserStats({
    required this.projectsAsHead,
    required this.finishedTasks,
    required this.ongoingTasks,
    required this.completionRate,
  });
}

// Nouvelle classe pour les rôles personnalisés
class CustomRole {
  final String id;
  final String title;
  final int priority;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CustomRole({
    required this.id,
    required this.title,
    required this.priority,
    required this.createdAt,
    this.updatedAt,
  });

  CustomRole copyWith({
    String? id,
    String? title,
    int? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomRole(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
