import '../enums.dart';

class UserData {
  final String id;
  final String name;
  final String email;
  final UserType userType;
  final String profilePictureUrl;
  final List<String> interests;
  final List<String> skills;
  final String availability;
  final List<String> volunteerActivities;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.userType = UserType.volunteer,
    this.profilePictureUrl = "",
    this.interests = const [],
    this.skills = const [],
    this.availability = "",
    this.volunteerActivities = const [],
  });

  // Convert a User objecx`t to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userType': enumToString(userType),
      'profilePictureUrl': profilePictureUrl,
      'interests': interests,
      'skills': skills,
      'availability': availability,
      'volunteerActivities': volunteerActivities,
    };
  }

  // Create a User object from a map
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userType: enumFromString(UserType.values, json['userType']),
      profilePictureUrl: json['profilePictureUrl'],
      interests: List<String>.from(json['interests']),
      skills: List<String>.from(json['skills']),
      availability: json['availability'],
      volunteerActivities: List<String>.from(json['volunteerActivities']),
    );
  }
}
