import '../enums.dart';

class UserData {
  final String id;
  final String name;
  final String username;
  final String email;
  final String bio;
  final UserType userType;
  final String profilePictureUrl;
  final List<dynamic> interests;
  final List<dynamic> skills;
  final List<dynamic> availability;
  final List<dynamic> volunteerActivities;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.bio = "",
    this.userType = UserType.volunteer,
    this.profilePictureUrl = "",
    this.interests = const [],
    this.skills = const [],
    this.availability = const [],
    this.volunteerActivities = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'userType': enumToString(userType),
      'profilePictureUrl': profilePictureUrl,
      'interests': interests,
      'skills': skills,
      'availability': availability,
      'volunteerActivities': volunteerActivities,
      'bio': bio,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      bio: json['bio'],
      userType: enumFromString(UserType.values, json['userType']),
      profilePictureUrl: json['profilePictureUrl'],
      interests: List<String>.from(json['interests']),
      skills: List<String>.from(json['skills']),
      availability: json['availability'],
      volunteerActivities: List<String>.from(json['volunteerActivities']),
    );
  }
}
