import 'package:volunteer_linker/core/enums.dart';

class ProfileInfo {
  final UserType userType;

  const ProfileInfo({
    required this.userType,
  });
  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      userType: enumFromString(UserType.values, json['userType']),
    );
  }
  toJson() {
    return {
      'userType': enumToString(userType),
    };
  }
}
