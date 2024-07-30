import 'location_model.dart';

class Opportunity {
  String id;
  String title;
  String description;
  String organizationId;
  LocationModel location;
  DateTime startDateTime;
  DateTime endDateTime;
  List<String> requiredSkills;
  List<String> registeredUsers;
  List<String> attendees;

  Opportunity({
    required this.id,
    required this.title,
    required this.description,
    required this.organizationId,
    required this.location,
    required this.startDateTime,
    required this.endDateTime,
    this.requiredSkills = const [],
    this.registeredUsers = const [],
    this.attendees = const [],
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      organizationId: json['organizationId'],
      location: LocationModel.fromJson(json['location']),
      startDateTime: DateTime.parse(json['date']),
      endDateTime: DateTime.parse(json['time']),
      requiredSkills: List<String>.from(json['requiredSkills']),
      registeredUsers: List<String>.from(json['registeredUsers']),
      attendees: List<String>.from(json['attendees']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'organizationId': organizationId,
      'location': location.toJson(),
      'date': startDateTime.toIso8601String(),
      'time': endDateTime.toIso8601String(),
      'requiredSkills': requiredSkills,
      'registeredUsers': registeredUsers,
      'attendees': attendees,
    };
  }
}
