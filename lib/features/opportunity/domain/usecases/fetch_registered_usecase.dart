import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/opportunity_repository.dart';

class FetchRegisteredUseCase {
  final OpportunityRepository _opportunityRepository;

  FetchRegisteredUseCase(this._opportunityRepository);

  Future<ApiResponse> call(
    List<String> registeredUsers,
  ) {
    return _opportunityRepository.fetchRegisteredUsers(
      registeredUsers: registeredUsers,
    );
  }
}
