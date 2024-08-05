import 'package:volunteer_linker/features/opportunity/data/model/opportunity.dart';

import '../../../../services/api_reponse.dart';

abstract class OpportunityRepository {
  Future<ApiResponse> postOpportunity({
    required Opportunity opportunity,
  });

  Future<ApiResponse> registerToOpportunity({
    required String opportunityId,
    required String userId,
  });

  Future<ApiResponse> fetchOpportunity({
    required String opportunityId,
  });

  Future<ApiResponse> fetchAttendants({
    required List<String> attendants,
  });

  Future<ApiResponse> fetchRegisteredUsers({
    required List<String> registeredUsers,
  });
}
