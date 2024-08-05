import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/opportunity_repository.dart';

class AttendOpportunityUsecase {
  final OpportunityRepository repository;

  AttendOpportunityUsecase(this.repository);

  Future<ApiResponse> registerToOpportunity({
    required String opportunityId,
    required String userId,
  }) async {
    return repository.registerToOpportunity(
      opportunityId: opportunityId,
      userId: userId,
    );
  }
}
