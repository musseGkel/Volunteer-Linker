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
  final LatLng location;
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
      selectedLocation: location,
    );
  }
}

class UpdateTempAddress extends OpportunityEvent {
  final String address;
  const UpdateTempAddress({
    required this.address,
  });

  @override
  List<Object> get props => [
        address,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    yield OpportunityState(
      address: address,
    );
  }
}

class UpdateTempDateTime extends OpportunityEvent {
  final DateTime startDateTime;
  final DateTime endDateTime;

  const UpdateTempDateTime({
    required this.endDateTime,
    required this.startDateTime,
  });

  @override
  List<Object> get props => [
        startDateTime,
        endDateTime,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    yield OpportunityState(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );
  }
}

class PostOpportunityEvent extends OpportunityEvent {
  final OpportunityState state;

  const PostOpportunityEvent({
    required this.state,
  });

  @override
  List<Object> get props => [
        state,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    // yield OpportunityState(
    //   startDateTime: startDateTime,
    //   endDateTime: endDateTime,
    // );
  }
}
