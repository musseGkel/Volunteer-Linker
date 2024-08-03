part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  Stream<HomePageState> handle();

  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends HomePageEvent {
  final HomePageState state;

  const FetchPostsEvent({
    required this.state,
  });

  @override
  List<Object> get props => [state];

  @override
  Stream<HomePageState> handle() async* {
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
