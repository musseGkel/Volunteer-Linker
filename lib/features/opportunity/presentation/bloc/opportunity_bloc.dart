import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:volunteer_linker/features/opportunity/data/model/location_model.dart';

import '../../../../constants/keyword_constants.dart';
import '../../../../services/api_reponse.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../image/data/datasource/image_datasource.dart';
import '../../../image/data/repository/image_repo_impl.dart';
import '../../../image/domain/usecases/store_image_usecase.dart';
import '../../data/datasource/opportunity_datasource.dart';
import '../../data/model/opportunity.dart';
import '../../data/repository/opportunity_repository_impl.dart';
import '../../domain/usecases/post_opportunity_usecase.dart';

part 'opportunity_event.dart';
part 'opportunity_state.dart';

class OpportunityBloc extends Bloc<OpportunityEvent, OpportunityState> {
  OpportunityBloc()
      : super(
          const OpportunityState(),
        ) {
    on<OpportunityEvent>(
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
