import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        var response =
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

  Future attendAnOpportunity(
      {required String opportunityId, required String userId}) async {
    try {
      var response =
          await _firestore.collection('posts').doc(opportunityId).update({
        'attendees': FieldValue.arrayUnion([userId])
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
}
