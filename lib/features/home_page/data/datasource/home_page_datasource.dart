import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../services/api_reponse.dart';
import '../../../opportunity/data/model/opportunity.dart';

class HomePageDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ApiResponse> fetchPosts({
    String userId = "",
    required DocumentSnapshot? startAfter,
    required int limit,
  }) async {
    try {
      Query query;
      if (userId.isEmpty) {
        query =
            _firestore.collection('posts').orderBy('createdAt').limit(limit);
      } else {
        query = _firestore
            .collection('posts')
            .where('userId', isEqualTo: userId)
            .orderBy('createdAt')
            .limit(limit);
      }

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<Opportunity> opportunities = querySnapshot.docs.map(
        (doc) {
          return Opportunity.fromJson(doc.data() as Map<String, dynamic>);
        },
      ).toList();

      return ApiResponse(
        statusCode: 200,
        message: "Success",
        body: {
          'opportunities': opportunities,
          'lastDocument':
              querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
        },
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }
}
