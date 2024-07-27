part of 'opportunity_bloc.dart';

sealed class OpportunityEvent extends Equatable {
  const OpportunityEvent();
  Stream<OpportunityState> handle();

  @override
  List<Object> get props => [];
}

class UpdateTempRequiredSkills extends OpportunityEvent {
  final List<String> requiredSkills;
  const UpdateTempRequiredSkills({
    required this.requiredSkills,
  });

  @override
  List<Object> get props => [
        requiredSkills,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    yield OpportunityState(
      tempRequiredSkills: requiredSkills,
    );
  }
}

class UpdateTempTitle extends OpportunityEvent {
  final String title;
  const UpdateTempTitle({
    required this.title,
  });

  @override
  List<Object> get props => [
        title,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    yield OpportunityState(
      tempTitle: title,
    );
  }
}

class UpdateTempDescription extends OpportunityEvent {
  final String description;
  const UpdateTempDescription({
    required this.description,
  });

  @override
  List<Object> get props => [
        description,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    yield OpportunityState(
      tempDescription: description,
    );
  }
}

class UpdateTempLocation extends OpportunityEvent {
  final List<String> location;
  const UpdateTempLocation({
    required this.location,
  });

  @override
  List<Object> get props => [
        location,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    yield OpportunityState(
      tempLocation: location,
    );
  }
}
