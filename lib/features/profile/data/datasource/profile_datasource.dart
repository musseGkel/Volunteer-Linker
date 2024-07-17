import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/core/models/user.dart';
import '../../../../services/api_reponse.dart';

class ProfileDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ApiResponse> getProfile(userId) async {
    try {
      var response = await _firestore.collection('users').doc(userId).get();

      return ApiResponse(
        statusCode: 200,
        message: "Success",
        body: UserData.fromJson(
          response.data()!,
        ),
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }

  Future<ApiResponse> updateProfile({
    required UserData user,
  }) async {
    try {
      await _firestore.collection('users').doc(user.id).set(
            user.toJson(),
          );
      return ApiResponse(
        statusCode: 200,
        message: "Success",
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }
}
