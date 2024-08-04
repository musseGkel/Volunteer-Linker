import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/core/models/user_data.dart';
import 'package:volunteer_linker/features/image/data/repository/image_repo_impl.dart';
import 'package:volunteer_linker/features/profile/data/datasource/profile_datasource.dart';
import 'package:volunteer_linker/features/profile/data/repository/profile_repository_impl.dart';
import 'package:volunteer_linker/services/api_reponse.dart';

import '../../../../../core/enums.dart';
import '../../../../../core/models/organization.dart';
import '../../../../image/data/datasource/image_datasource.dart';
import '../../../../image/domain/usecases/store_image_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ProfileBloc()
      : super(
          ProfileState(userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
        ) {
    on<ProfileEvent>(
      (event, emit) async {
        await emit.forEach(
          event.handle(),
          onData: (state) {
            return state;
          },
        );
      },
    );
  }
}
