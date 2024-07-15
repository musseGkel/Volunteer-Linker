import 'package:http/http.dart';

class ApiResponse {
  final int statusCode;
  final dynamic body;
  final String message;
  ApiResponse({
    required this.statusCode,
    required this.message,
    this.body,
  });

  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(
      statusCode: response.statusCode,
      body: response.body,
      message: response.reasonPhrase!,
    );
  }
}