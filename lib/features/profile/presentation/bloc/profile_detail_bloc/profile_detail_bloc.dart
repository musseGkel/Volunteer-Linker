import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteer_linker/core/enums.dart';

import '../../../../../constants/keyword_constants.dart';

part 'profile_detail_event.dart';
part 'profile_detail_state.dart';

class ProfileDetailBloc extends Bloc<ProfileDetailEvent, ProfileDetailState> {
  ProfileDetailBloc() : super(const ProfileDetailState()) {
    on<ProfileDetailEvent>((event, emit) {});
  }
}
