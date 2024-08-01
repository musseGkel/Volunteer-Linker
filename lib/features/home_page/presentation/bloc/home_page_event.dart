part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  Stream<HomePageState> handle();

  @override
  List<Object> get props => [];
}
