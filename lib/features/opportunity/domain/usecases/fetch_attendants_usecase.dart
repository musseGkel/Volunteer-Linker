import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/opportunity_repository.dart';

class FetchAttendantsUseCase {
  final OpportunityRepository _opportunityRepository;

  FetchAttendantsUseCase(
    this._opportunityRepository,
  );

  Future<ApiResponse> call(
    List<String> attendants,
  ) {
    return _opportunityRepository.fetchAttendants(
      attendants: attendants,
    );
  }
}
