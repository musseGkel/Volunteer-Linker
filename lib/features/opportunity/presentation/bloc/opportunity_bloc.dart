import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../constants/keyword_constants.dart';

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
