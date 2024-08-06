import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/core/models/organization.dart';
import 'package:volunteer_linker/core/models/profile_info.dart';
import 'package:volunteer_linker/core/models/user_data.dart';
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

  Future<ApiResponse> getOrganizationProfile(userId) async {
    try {
      var response =
          await _firestore.collection('organizations').doc(userId).get();
      return ApiResponse(
        statusCode: 200,
        message: "Success",
        body: Organization.fromJson(
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
      print("organizationId: ${user.id}");

      await _firestore.collection('users').doc(user.id).set(
            user.toJson(),
          );
      print("updateProfile Success");

      return ApiResponse(
        statusCode: 200,
        message: "Success",
      );
    } catch (e) {
      print("Error: $e");
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }

  Future<ApiResponse> updateOrganizationProfile({
    required Organization organization,
  }) async {
    try {
      print("organizationId: ${organization.id}");
      await _firestore.collection('organizations').doc(organization.id).set(
            organization.toJson(),
          );
      print("updateOrganizationProfile ");
      return ApiResponse(
        statusCode: 200,
        message: "Success",
      );
    } catch (e) {
      print("Error: $e");
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }

  Future<ApiResponse> getProfileInfo(
    userId,
  ) async {
    try {
      var response =
          await _firestore.collection('profileInfo').doc(userId).get();
      return ApiResponse(
        statusCode: 200,
        message: "Success",
        body: ProfileInfo.fromJson(
          response.data() ?? {},
        ),
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }
}
