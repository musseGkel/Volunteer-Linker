class LocationModel {
  double latitude;
  double longitude;
  String readableAddress;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.readableAddress,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      readableAddress: json['readableAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'readableAddress': readableAddress,
    };
  }
}
