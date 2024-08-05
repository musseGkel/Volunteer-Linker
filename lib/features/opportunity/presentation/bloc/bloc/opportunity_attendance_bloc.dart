import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:volunteer_linker/features/opportunity/domain/usecases/attend_opportunity_usecase.dart';
import 'package:volunteer_linker/services/api_reponse.dart';

import '../../../../../core/models/user_data.dart';
import '../../../../home_page/data/datasource/home_page_datasource.dart';
import '../../../../home_page/data/repository/home_page_repo_impl.dart';
import '../../../../home_page/domain/usecases/fetch_posts_usecase.dart';
import '../../../../home_page/presentation/bloc/home_page_bloc.dart';
import '../../../data/datasource/opportunity_datasource.dart';
import '../../../data/model/opportunity.dart';
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
