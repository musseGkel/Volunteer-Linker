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
  Future<ApiResponse> registerToOpportunity(
      {required String opportunityId, required String userId}) async {
    return await remoteDataSource.registerToOpportunity(
      opportunityId: opportunityId,
      userId: userId,
    );
  }

  @override
  Future<ApiResponse> fetchAttendants({required List<String> attendants}) {
    return remoteDataSource.fetchAttendants(
      attendants: attendants,
    );
  }

  @override
  Future<ApiResponse> fetchOpportunity({required String opportunityId}) {
    return remoteDataSource.fetchOpportunity(
      opportunityId: opportunityId,
    );
  }

  @override
  Future<ApiResponse> fetchRegisteredUsers(
      {required List<String> registeredUsers}) {
    return remoteDataSource.fetchRegisteredUsers(
      registeredUsers: registeredUsers,
    );
  }
}
