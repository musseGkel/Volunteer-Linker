enum UserType {
  volunteer,
  organization,
}

enum AuthMode {
  login,
  register,
}

String enumToString(Object enumValue) {
  return enumValue.toString().split('.').last;
}

T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => enumToString(v as Object) == value,
      orElse: () => throw ArgumentError('No matching enum value found'));
}
