import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'keyword_selection_event.dart';
part 'keyword_selection_state.dart';

class KeywordSelectionBloc
    extends Bloc<KeywordSelectionEvent, KeywordSelectionState> {
  KeywordSelectionBloc() : super(const KeywordSelectionState()) {
    on<KeywordSelectionEvent>(
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
