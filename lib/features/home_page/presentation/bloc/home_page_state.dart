part of 'home_page_bloc.dart';

enum PostStatus { initial, success, failure }

class HomePageState extends Equatable {
  final PostStatus status;
  final List<Opportunity> opportunities;
  final bool hasReachedMax;
  final DocumentSnapshot? lastDocument;

  const HomePageState({
    this.status = PostStatus.initial,
    this.opportunities = const [],
    this.hasReachedMax = false,
    this.lastDocument,
  });

  HomePageState copyWith({
    PostStatus? status,
    List<Opportunity>? opportunities,
    bool? hasReachedMax,
    DocumentSnapshot? lastDocument,
  }) {
    return HomePageState(
      status: status ?? this.status,
      opportunities: opportunities ?? this.opportunities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }

  @override
  List<Object?> get props => [
        status,
        opportunities,
        hasReachedMax,
        lastDocument,
      ];

  String getTimeAgo(
    DateTime dateTime,
  ) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat.yMMMd().format(dateTime);
    }
  }
}
