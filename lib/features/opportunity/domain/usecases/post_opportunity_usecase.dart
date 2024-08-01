import 'package:volunteer_linker/services/api_reponse.dart';

import '../../data/model/opportunity.dart';
import '../repository/opportunity_repository.dart';

class PostOpportunityUsecase {
  final OpportunityRepository repository;

  PostOpportunityUsecase(this.repository);

  Future<ApiResponse> call(Opportunity opportunity) async {
    return repository.postOpportunity(
      opportunity: opportunity,
    );
  }
}
