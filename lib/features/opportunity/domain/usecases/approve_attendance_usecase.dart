import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/opportunity_repository.dart';

class ApproveAttendanceUsecase {
  final OpportunityRepository repository;

  ApproveAttendanceUsecase(this.repository);

  Future<ApiResponse> approveAttendance({
    required String opportunityId,
    required String userId,
    required String companyName,
  }) async {
    return repository.approveAttendance(
      opportunityId: opportunityId,
      userId: userId,
      companyName: companyName,
    );
  }
}
