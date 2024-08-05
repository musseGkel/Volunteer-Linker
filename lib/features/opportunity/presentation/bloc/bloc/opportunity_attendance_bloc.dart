import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteer_linker/features/opportunity/domain/usecases/attend_opportunity_usecase.dart';
import 'package:volunteer_linker/services/api_reponse.dart';

import '../../../data/datasource/opportunity_datasource.dart';
import '../../../data/repository/opportunity_repository_impl.dart';

part 'opportunity_attendance_event.dart';
part 'opportunity_attendance_state.dart';

class OpportunityAttendanceBloc
    extends Bloc<OpportunityAttendanceEvent, OpportunityAttendanceState> {
  OpportunityAttendanceBloc() : super(const OpportunityAttendanceState()) {
    on<OpportunityAttendanceEvent>(
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
