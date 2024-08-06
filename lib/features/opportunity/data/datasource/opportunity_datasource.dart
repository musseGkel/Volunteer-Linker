import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/core/models/user_data.dart';

import '../../../../services/api_reponse.dart';
import '../model/opportunity.dart';

class OpportunityDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future postOpportunity({required Opportunity opportunity}) async {
    try {
      if (currentUser == null) {
        return ApiResponse(
          statusCode: 400,
          message: "Error",
        );
      } else {
        await _firestore.collection('posts').doc(opportunity.id).set(
              opportunity.toJson(),
            );

        return ApiResponse(
          statusCode: 200,
          message: "Success",
        );
      }
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }

  Future<ApiResponse> registerToOpportunity({
    required String opportunityId,
    required String userId,
  }) async {
    try {
      var response =
          await _firestore.collection('posts').doc(opportunityId).update({
        'registeredUsers': FieldValue.arrayUnion(
          [userId],
        )
      });

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

  Future<ApiResponse> approveAttendance({
    required String opportunityId,
    required String userId,
    required String companyName,
  }) async {
    final DocumentReference opportunityRef =
        _firestore.collection('posts').doc(opportunityId);
    final DocumentReference userRef =
        _firestore.collection('users').doc(userId);

    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot opportunitySnapshot =
            await transaction.get(opportunityRef);
        DocumentSnapshot userSnapshot = await transaction.get(userRef);

        if (!opportunitySnapshot.exists) {
          throw Exception("Opportunity does not exist");
        }
        if (!userSnapshot.exists) {
          throw Exception("User does not exist");
        }

        List<String> attendees = List.from(opportunitySnapshot['attendees']);
        List<String> registeredUsers =
            List.from(opportunitySnapshot['registeredUsers']);

        if (!attendees.contains(userId)) {
          attendees.add(userId);
        }
        if (registeredUsers.contains(userId)) {
          registeredUsers.remove(userId);
        }

        transaction.update(opportunityRef, {
          'attendees': attendees,
          'registeredUsers': registeredUsers,
        });

        List<String> volunteerActivities =
            List.from(userSnapshot['volunteerActivities']);
        if (!volunteerActivities.contains(companyName)) {
          volunteerActivities.add(companyName);
        }

        transaction.update(userRef, {
          'volunteerActivities': volunteerActivities,
        });
      });

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

  Future<ApiResponse> fetchOpportunity({
    required String opportunityId,
  }) async {
    try {
      var response =
          await _firestore.collection('posts').doc(opportunityId).get();

      return ApiResponse(
        statusCode: 200,
        message: "Success",
        body: Opportunity.fromJson(
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

  Future<ApiResponse> fetchAttendants({
    required List<String> attendants,
  }) async {
    try {
      List<UserData> users = [];

      for (String userId in attendants) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        if (userDoc.exists) {
          users.add(UserData.fromJson(userDoc.data() as Map<String, dynamic>));
        }
      }

      return ApiResponse(
        statusCode: 200,
        message: "Success",
        body: users,
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }

  Future<ApiResponse> fetchRegisteredUsers({
    required List<String> registeredUsers,
  }) async {
    List<UserData> users = [];

    for (String userId in registeredUsers) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        users.add(UserData.fromJson(userDoc.data() as Map<String, dynamic>));
      }
    }

    return ApiResponse(
      statusCode: 200,
      message: "Success",
      body: users,
    );
  }
}
