import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'keyword_selection_event.dart';
part 'keyword_selection_state.dart';

class KeywordSelectionBloc
    extends Bloc<KeywordSelectionEvent, KeywordSelectionState> {
  final List<String> selectedWords;
  KeywordSelectionBloc(this.selectedWords)
      : super(
          KeywordSelectionState(
            selectedKeywords: selectedWords,
          ),
        ) {
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
