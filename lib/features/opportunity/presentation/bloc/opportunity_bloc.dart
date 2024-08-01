import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:volunteer_linker/features/opportunity/data/model/location_model.dart';

import '../../../../constants/keyword_constants.dart';
import '../../../../services/api_reponse.dart';
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
