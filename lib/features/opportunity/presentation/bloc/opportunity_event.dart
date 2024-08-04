part of 'opportunity_bloc.dart';

sealed class OpportunityEvent extends Equatable {
  const OpportunityEvent();
  Stream<OpportunityState> handle();

  @override
  List<Object> get props => [];
}

class UpdateTempRequiredSkills extends OpportunityEvent {
  final List<String> requiredSkills;
  final OpportunityState state;

  const UpdateTempRequiredSkills({
    required this.requiredSkills,
    required this.state,
  });

  @override
  List<Object> get props => [
        requiredSkills,
        state,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    OpportunityState updateState = state.copyWith(
      tempRequiredSkills: requiredSkills,
    );

    yield updateState;
  }
}

class UpdateTempTitle extends OpportunityEvent {
  final OpportunityState state;

  final String title;
  const UpdateTempTitle({
    required this.title,
    required this.state,
  });

  @override
  List<Object> get props => [
        title,
        state,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    OpportunityState updateState = state.copyWith(
      tempTitle: title,
    );

    yield updateState;
  }
}

class UpdateTempDescription extends OpportunityEvent {
  final OpportunityState state;
  final String description;
  const UpdateTempDescription({
    required this.description,
    required this.state,
  });

  @override
  List<Object> get props => [
        description,
        state,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    OpportunityState updateState = state.copyWith(
      tempDescription: description,
    );
    yield updateState;
  }
}

class UpdateTempLocation extends OpportunityEvent {
  final OpportunityState state;
  final LatLng location;
  const UpdateTempLocation({
    required this.location,
    required this.state,
  });

  @override
  List<Object> get props => [
        location,
        state,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    String address = "";

    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      address =
          "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
    }
    OpportunityState updateState = state.copyWith(
      selectedLocation: location,
      address: address,
    );

    yield updateState;
  }
}

class UpdateTempDateTime extends OpportunityEvent {
  final OpportunityState state;
  final DateTime startDateTime;
  final DateTime endDateTime;

  const UpdateTempDateTime({
    required this.endDateTime,
    required this.startDateTime,
    required this.state,
  });

  @override
  List<Object> get props => [
        startDateTime,
        endDateTime,
        state,
      ];

  @override
  Stream<OpportunityState> handle() async* {
    OpportunityState updateState = state.copyWith(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );

    yield updateState;
  }
}

class PostOpportunityEvent extends OpportunityEvent {
  final OpportunityState state;
  final String organizationId;
  final AuthState authState;
  final File? image;
  final String organizationName;
  final String organizationLogoUrl;

  const PostOpportunityEvent({
    required this.state,
    required this.organizationId,
    required this.authState,
    this.image,
    required this.organizationName,
    required this.organizationLogoUrl,
  });

  @override
  Stream<OpportunityState> handle() async* {
    OpportunityState updateState = state.copyWith(
      isLoading: true,
    );
    yield updateState;

    ApiResponse imageStorageResponse;
    String uploadedImageUrl = "";

    if (image != null) {
      imageStorageResponse = await StoreImageUsecase(
        ImageRepoImpl(
          dataSource: ImageDataSource(),
        ),
      ).call(
        image!,
      );
      if (imageStorageResponse.statusCode == 200) {
        uploadedImageUrl = imageStorageResponse.body;
      } else {
        updateState = state.copyWith(
          isLoading: false,
        );
        yield updateState;
        return;
      }
    }

    if (state.tempTitle.isEmpty ||
        state.selectedLocation == null ||
        state.address == null ||
        state.startDateTime == null ||
        state.endDateTime == null ||
        state.tempRequiredSkills == null) {
      updateState = state.copyWith(
        isLoading: false,
        errorMesssage: "Please fill all fields",
      );
      yield updateState;
      return;
    } else {
      var uuid = const Uuid();
      String opportunityId = uuid.v4();
      ApiResponse response = await PostOpportunityUsecase(
        OpportunityRepositoryImpl(
          remoteDataSource: OpportunityDatasource(),
        ),
      ).call(
        Opportunity(
          id: opportunityId,
          organizationId: organizationId,
          title: state.tempTitle,
          description: state.tempDescription,
          location: LocationModel(
              latitude: state.selectedLocation?.latitude ?? 0,
              longitude: state.selectedLocation?.longitude ?? 0,
              readableAddress: state.address ?? ''),
          startDateTime: state.startDateTime ?? DateTime.now(),
          endDateTime: state.endDateTime ?? DateTime.now(),
          requiredSkills: state.tempRequiredSkills ?? [],
          createdAt: DateTime.now(),
          imageUrl: uploadedImageUrl,
          organizationLogoUrl: organizationLogoUrl,
          organizationName: organizationName,
        ),
      );
      if (response.statusCode != 200) {
        updateState = state.copyWith(
          isLoading: false,
          errorMesssage: response.message,
        );
        yield updateState;
        return;
      } else {
        updateState = state.copyWith(isLoading: false, opportunityPosted: true);
        yield updateState;

        updateState = state.copyWith(opportunityPosted: false);
        yield updateState;
      }
    }
  }
}
