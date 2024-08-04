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
  final ProfileState state;
  final File? image;

  const UpdateProfile({
    required this.state,
    required this.id,
    this.image,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
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
        print("Image uploaded successfully");
        uploadedImageUrl = imageStorageResponse.body;
      } else {
        print("Image upload failed");
        updateState = state.copywith(
          isLoading: false,
          error: imageStorageResponse.message,
        );
        yield updateState;
        return;
      }
    }

    ApiResponse response;
    if (state.checkUserType(UserType.volunteer)) {
      response = await ProfileRepositoryImpl(
        datasource: ProfileDatasource(),
      ).updateProfile(
        user: UserData(
          id: id,
          name: state.tempName ?? "",
          email: state.tempEmail ?? "",
          username: state.tempUsername ?? "",
          bio: state.tempBio ?? "",
          userType: state.user?.userType ?? UserType.volunteer,
          profilePictureUrl:
              uploadedImageUrl.isNotEmpty ? uploadedImageUrl : "",
          interests: state.tempInterests ?? [],
          skills: state.tempSkills ?? [],
          availability: state.tempAvailability ?? {},
          volunteerActivities: state.tempVolunteerActivities ?? [],
          phoneNumber: state.tempPhoneNumber ?? "",
        ),
      );
    } else {
      response = await ProfileRepositoryImpl(
        datasource: ProfileDatasource(),
      ).updateOrganizationProfile(
        organization: Organization(
          id: id,
          name: state.tempName ?? "",
          email: state.tempEmail ?? "",
          userName: state.tempUsername ?? "",
          userType: state.user?.userType ?? UserType.organization,
          contactNumber: state.tempPhoneNumber ?? "",
          description: state.tempBio ?? "",
          address: state.tempAddress ?? "",
          profilePictureUrl:
              uploadedImageUrl.isNotEmpty ? uploadedImageUrl : "",
          postedOpportunities: [],
        ),
      );
    }

    if (response.statusCode != 200) {
      updateState = state.copywith(
        isLoading: false,
      );
      yield updateState;
      return;
    } else {
      updateState = state.copywith(
        isLoading: false,
        editMode: false,
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
    ApiResponse response;

    ApiResponse profileInfoResponse = await ProfileRepositoryImpl(
      datasource: ProfileDatasource(),
    ).getProfileInfo(
      userId: state.userId,
    );

    if (profileInfoResponse.statusCode != 200) {
      updateState = state.copywith(
        isLoading: false,
        error: profileInfoResponse.message,
      );
      yield updateState;
      return;
    } else {
      if (profileInfoResponse.body.userType == UserType.organization) {
        response = await ProfileRepositoryImpl(
          datasource: ProfileDatasource(),
        ).getOrganizationProfile(
          userId: state.userId,
        );
      } else {
        response = await ProfileRepositoryImpl(
          datasource: ProfileDatasource(),
        ).getProfile(
          userId: state.userId,
        );
      }

      if (response.statusCode != 200) {
        updateState = state.copywith(
          isLoading: false,
        );
        yield updateState;
        return;
      } else {
        if (response.body.userType == UserType.organization) {
          updateState = state.copywith(
            organization: response.body as Organization,
            isLoading: false,
            tempName: response.body.name,
            tempEmail: response.body.email,
            tempPhoneNumber: response.body.contactNumber,
            tempBio: response.body.description,
            tempAddress: response.body.address,
            tempProfilePictureUrl: response.body.profilePictureUrl,
            tempUserType: response.body.userType,
          );
        } else {
          updateState = state.copywith(
              user: response.body as UserData,
              isLoading: false,
              tempName: response.body.name,
              tempUsername: response.body.username,
              tempEmail: response.body.email,
              tempBio: response.body.bio,
              tempSkills: response.body.skills,
              tempInterests: response.body.interests,
              tempAvailability: response.body.availability,
              tempVolunteerActivities: response.body.volunteerActivities,
              tempPhoneNumber: response.body.phoneNumber,
              tempProfilePictureUrl: response.body.profilePictureUrl,
              tempUserType: response.body.userType);
        }

        yield updateState;
      }
    }
  }
}

class UpdateTempName extends ProfileEvent {
  final String name;
  final ProfileState state;

  const UpdateTempName({
    required this.state,
    required this.name,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempName: name,
    );
    yield updateState;
  }
}

class UpdateTempUsername extends ProfileEvent {
  final String username;
  final ProfileState state;

  const UpdateTempUsername({
    required this.state,
    required this.username,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempUsername: username,
    );
    yield updateState;
  }
}

class UpdateTempEmail extends ProfileEvent {
  final String email;
  final ProfileState state;

  const UpdateTempEmail({
    required this.state,
    required this.email,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempEmail: email,
    );
    yield updateState;
  }
}

class UpdateTempAddress extends ProfileEvent {
  final String address;
  final ProfileState state;

  const UpdateTempAddress({
    required this.state,
    required this.address,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempAddress: address,
    );
    yield updateState;
  }
}

class UpdateTempBio extends ProfileEvent {
  final String bio;
  final ProfileState state;

  const UpdateTempBio({
    required this.state,
    required this.bio,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempBio: bio,
    );
    yield updateState;
  }
}

class UpdatePhoneNumber extends ProfileEvent {
  final String phoneNumber;
  final ProfileState state;

  const UpdatePhoneNumber({
    required this.state,
    required this.phoneNumber,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempPhoneNumber: phoneNumber,
    );
    yield updateState;
  }
}

class UpdateSkills extends ProfileEvent {
  final List<String> skills;
  final ProfileState state;

  const UpdateSkills({
    required this.state,
    required this.skills,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempSkills: skills,
    );
    yield updateState;
  }
}

class UpdateAvailability extends ProfileEvent {
  final Map<String, List<TimeRange>> availability;
  final ProfileState state;

  const UpdateAvailability({
    required this.state,
    required this.availability,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempAvailability: availability,
    );
    yield updateState;
  }
}
