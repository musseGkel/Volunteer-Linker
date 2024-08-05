import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/opportunity_repository.dart';

class AttendOpportunityUsecase {
  final OpportunityRepository repository;

  AttendOpportunityUsecase(this.repository);

  Future<ApiResponse> attendAnOpportunity({
    required String opportunityId,
    required String userId,
  }) async {
    return repository.attendAnOpportunity(
      opportunityId: opportunityId,
      userId: userId,
    );
  }
}
