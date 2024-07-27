class Opportunity {
  String id;
  String title;
  String description;
  String organizationId;
  String location;
  DateTime date;
  DateTime time;
  int duration;
  List<String> requiredSkills;
  List<String> registeredUsers;
  List<String> attendees;

  Opportunity({
    required this.id,
    required this.title,
    required this.description,
    required this.organizationId,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
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
      location: json['location'],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      duration: json['duration'],
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
      'location': location,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'duration': duration,
      'requiredSkills': requiredSkills,
      'registeredUsers': registeredUsers,
      'attendees': attendees,
    };
  }
}
