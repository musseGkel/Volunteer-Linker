import 'package:volunteer_linker/features/opportunity/data/model/opportunity.dart';

import '../../../../services/api_reponse.dart';

abstract class OpportunityRepository {
  Future<ApiResponse> postOpportunity({
    required Opportunity opportunity,
  });
}
