import 'package:flutter/material.dart';
import '../enums.dart';

class UserData {
  final String id;
  final String name;
  final String username;
  final String email;
  final String bio;
  final UserType userType;
  final String profilePictureUrl;
  final List<String> interests;
  final List<String> skills;
  final Map<String, List<TimeRange>> availability;
  final List<String> volunteerActivities;
  final String phoneNumber;

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
    this.availability = const {},
    this.volunteerActivities = const [],
    this.phoneNumber = "",
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
      'availability': availability.map((key, value) =>
          MapEntry(key, value.map((timeRange) => timeRange.toJson()).toList())),
      'volunteerActivities': volunteerActivities,
      'bio': bio,
      'phoneNumber': phoneNumber,
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
      availability: (json['availability'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((item) => TimeRange.fromJson(item)).toList(),
        ),
      ),
      volunteerActivities: List<String>.from(json['volunteerActivities']),
      phoneNumber: json['phoneNumber'] ?? "",
    );
  }
}

class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRange(this.start, this.end);

  String format(BuildContext context) {
    return '${start.format(context)} to ${end.format(context)}';
  }

  // Add this method to convert TimeOfDay to Map
  Map<String, int> _timeOfDayToJson(TimeOfDay time) {
    return {
      'hour': time.hour,
      'minute': time.minute,
    };
  }

  // Add this method to convert Map to TimeOfDay
  TimeOfDay _timeOfDayFromJson(Map<String, int> json) {
    return TimeOfDay(hour: json['hour']!, minute: json['minute']!);
  }

  // Convert TimeRange to JSON
  Map<String, dynamic> toJson() {
    return {
      'start': _timeOfDayToJson(start),
      'end': _timeOfDayToJson(end),
    };
  }

  // Create TimeRange from JSON
  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      TimeOfDay(hour: json['start']['hour'], minute: json['start']['minute']),
      TimeOfDay(hour: json['end']['hour'], minute: json['end']['minute']),
    );
  }
}
