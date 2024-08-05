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

class FetchUserPostsEvent extends OpportunityAttendanceEvent {
  final String userId;

  final OpportunityAttendanceState state;

  const FetchUserPostsEvent({
    required this.state,
    required this.userId,
  });

  @override
  List<Object> get props => [state];

  @override
  Stream<OpportunityAttendanceState> handle() async* {
    ApiResponse response;

    if (state.hasReachedMax) return;

    try {
      if (state.status == PostStatus.initial) {
        response = await FetchPostsUseCase(
          HomePageRepoImpl(
            HomePageDatasource(),
          ),
        ).call(
          startAfter: null,
          limit: 10,
          userId: userId,
        );

        var data = response.body as Map<String, dynamic>;
        List<Opportunity> opportunities = data['opportunities'];
        DocumentSnapshot? lastDocument = data['lastDocument'];

        yield state.copyWith(
          status: PostStatus.success,
          opportunities: opportunities,
          lastDocument: lastDocument,
          hasReachedMax: response.body.length < 10,
        );
      } else if (state.status == PostStatus.success) {
        response = await FetchPostsUseCase(
          HomePageRepoImpl(
            HomePageDatasource(),
          ),
        ).call(
          startAfter: state.lastDocument,
          limit: 10,
          userId: userId,
        );
        var data = response.body as Map<String, dynamic>;
        List<Opportunity> opportunities = data['opportunities'];
        DocumentSnapshot? lastDocument = data['lastDocument'];

        yield response.body.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: PostStatus.success,
                opportunities: List.of(state.opportunities)
                  ..addAll(opportunities),
                lastDocument: lastDocument,
                hasReachedMax: response.body.length < 10,
              );
      }
    } catch (_) {
      yield state.copyWith(
        status: PostStatus.failure,
      );
    }
  }
}
