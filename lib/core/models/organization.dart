import '../enums.dart';

class Organization {
  final String id;
  final String name;
  final String email;
  final String userName;
  final UserType userType;
  final String contactNumber;
  final String description;
  final String address;
  final String profilePictureUrl;
  final List<String> postedOpportunities;

  Organization({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    this.userType = UserType.organization,
    this.contactNumber = "",
    this.description = "",
    this.address = "",
    this.profilePictureUrl = "",
    this.postedOpportunities = const [],
  });

  // Convert an Organization object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userName': userName,
      'userType': enumToString(userType),
      'contactNumber': contactNumber,
      'description': description,
      'address': address,
      'profilePictureUrl': profilePictureUrl,
      'postedOpportunities': postedOpportunities,
    };
  }

  // Create an Organization object from a map
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userName: json['username'] ?? "",
      userType: enumFromString(UserType.values, json['userType']),
      contactNumber: json['contactNumber'],
      description: json['description'],
      address: json['address'],
      profilePictureUrl: json['profilePictureUrl'],
      postedOpportunities: List<String>.from(json['postedOpportunities']),
    );
  }
}
