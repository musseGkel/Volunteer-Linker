import '../../../../services/api_reponse.dart';
import '../../domain/repository/opportunity_repository.dart';
import '../datasource/opportunity_datasource.dart';
import '../model/opportunity.dart';

class OpportunityRepositoryImpl implements OpportunityRepository {
  final OpportunityDatasource remoteDataSource;

  OpportunityRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResponse> postOpportunity({
    required Opportunity opportunity,
  }) async {
    return await remoteDataSource.postOpportunity(
      opportunity: opportunity,
    );
  }

  @override
  Future<ApiResponse> attendAnOpportunity(
      {required String opportunityId, required String userId}) async {
    return await remoteDataSource.attendAnOpportunity(
      opportunityId: opportunityId,
      userId: userId,
    );
  }
}
