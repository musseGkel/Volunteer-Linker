part of 'opportunity_attendance_bloc.dart';

sealed class OpportunityAttendanceEvent extends Equatable {
  Stream<OpportunityAttendanceState> handle();

  const OpportunityAttendanceEvent();

  @override
  List<Object> get props => [];
}

class AttendAnOpportunity extends OpportunityAttendanceEvent {
  final String opportunityId;
  final String userId;

  const AttendAnOpportunity({
    required this.opportunityId,
    required this.userId,
  });

  @override
  List<Object> get props => [
        opportunityId,
        userId,
      ];

  @override
  Stream<OpportunityAttendanceState> handle() async* {
    yield const OpportunityAttendanceState(isLoading: true);

    ApiResponse response = await AttendOpportunityUsecase(
      OpportunityRepositoryImpl(
        remoteDataSource: OpportunityDatasource(),
      ),
    ).attendAnOpportunity(
      opportunityId: opportunityId,
      userId: userId,
    );

    yield const OpportunityAttendanceState(isLoading: false);
  }
}
