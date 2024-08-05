import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/opportunity_repository.dart';

class FetchOpportunityUsecase {
  final OpportunityRepository _opportunityRepository;

  FetchOpportunityUsecase(
    this._opportunityRepository,
  );

  Future<ApiResponse> call(
    String opportunityId,
  ) {
    return _opportunityRepository.fetchOpportunity(
      opportunityId: opportunityId,
    );
  }
}
