part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
  Stream<ProfileState> handle();

  @override
  List<Object> get props => [];
}

class ProfileEditModeChanged extends ProfileEvent {
  final ProfileState state;
  const ProfileEditModeChanged({
    required this.state,
  });

  @override
  List<Object> get props => [
        state,
      ];

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updatedState = state.copywith(
      editMode: !state.editMode,
    );
    yield updatedState;
  }
}

class UpdateProfile extends ProfileEvent {
  final String id;
  final String name;
  final String email;
  final String username;
  final String? bio;
  final UserType userType;
  final String? profilePictureUrl;
  final List<String> interests;
  final List<String> skills;
  final List<String> availability;
  final List<String> volunteerActivities;
  final ProfileState state;

  const UpdateProfile({
    required this.state,
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.bio,
    required this.userType,
    this.profilePictureUrl,
    this.interests = const [],
    this.skills = const [],
    this.availability = const [],
    this.volunteerActivities = const [],
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      isLoading: true,
    );
    yield updateState;

    ApiResponse response = await ProfileRepositoryImpl(
      datasource: ProfileDatasource(),
    ).updateProfile(
      user: UserData(
        id: id,
        name: name,
        email: email,
        username: username,
        bio: bio ?? "",
        userType: userType,
        profilePictureUrl: profilePictureUrl ?? "",
        interests: interests,
        skills: skills,
        availability: availability,
        volunteerActivities: volunteerActivities,
      ),
    );

    if (response.statusCode != 200) {
      updateState = state.copywith(
        isLoading: false,
      );
      yield updateState;
      return;
    } else {
      print("##########################");
      print("Profile Updated");
      print(response.statusCode);
      print(response.body);
      updateState = state.copywith(
        isLoading: false,
      );

      yield updateState;
    }
  }
}

class GetProfile extends ProfileEvent {
  final ProfileState state;

  const GetProfile({
    required this.state,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      isLoading: true,
    );
    yield updateState;
    ApiResponse response = await ProfileRepositoryImpl(
      datasource: ProfileDatasource(),
    ).getProfile(
      userId: state.userId,
    );

    if (response.statusCode != 200) {
      print("##########################");
      print("Profile Not Retrieved");
      updateState = state.copywith(
        isLoading: false,
      );
      yield updateState;
      return;
    } else {
      print("##########################");
      print("Profile Retrieved");
      print(response.statusCode);
      print(response.body);
      updateState = state.copywith(
        user: response.body as UserData,
      );
      yield updateState;
    }
  }
}
