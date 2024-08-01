part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];

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
