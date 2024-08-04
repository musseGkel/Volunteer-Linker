import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/app_colors.dart';
import 'package:volunteer_linker/features/profile/presentation/bloc/key_selection_bloc/keyword_selection_bloc.dart';
import '../../../../core/enums.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../home_page/presentation/bloc/image_picker/image_picker_bloc.dart';
import '../bloc/profile_bloc/profile_bloc.dart';
import '../bloc/profile_detail_bloc/profile_detail_bloc.dart';
import '../widgets/profile_detail.dart';
import '../widgets/profile_detail_expansion_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(
          GetProfile(
            state: context.read<ProfileBloc>().state,
          ),
        );
  }

  void _showImageSourceActionSheet(
    BuildContext context,
    ImagePickerState imagePickerState,
  ) {
    final imagePickerBloc = BlocProvider.of<ImagePickerBloc>(context);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: imagePickerBloc,
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick from gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    imagePickerBloc.add(
                        PickImageFromGalleryEvent(state: imagePickerState));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () {
                    Navigator.of(context).pop();
                    imagePickerBloc
                        .add(TakePhotoEvent(state: imagePickerState));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KeywordSelectionBloc>(
          create: (context) => KeywordSelectionBloc(
            context.read<ProfileBloc>().state.tempSkills ?? [] as List<String>,
          ),
        ),
        BlocProvider<ProfileDetailBloc>(
          create: (context) => ProfileDetailBloc(),
        ),
        BlocProvider<ImagePickerBloc>(
          create: (context) => ImagePickerBloc(),
        ),
      ],
      child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (imagePickerContext, imagePickerState) {
          return BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, profileState) {},
            builder: (context, profileState) {
              return profileState.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        backgroundColor: AppColors.transparent,
                        elevation: 0,
                        leading: const Icon(
                          Icons.arrow_back,
                          color: AppColors.primaryColor,
                        ),
                        actions: [
                          profileState.editMode
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: AppColors.backgroundColor,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateProfile(
                                        state: profileState,
                                        id: profileState.userId,
                                        image: imagePickerState.image,
                                      ),
                                    );
                                  },
                                )
                              : PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: AppColors.backgroundColor,
                                  ),
                                  onSelected: (String value) {
                                    if (value == 'edit') {
                                      BlocProvider.of<ProfileBloc>(context).add(
                                        ProfileEditModeChanged(
                                          state: profileState,
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      const PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Text('Edit Profile'),
                                      ),
                                    ];
                                  },
                                ),
                        ],
                      ),
                      extendBodyBehindAppBar: true,
                      body: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 50,
                            ),
                            height: 350,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.softGray,
                                  AppColors.secondaryTextColor
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    BlocBuilder<ImagePickerBloc,
                                        ImagePickerState>(
                                      builder: (context, state) {
                                        return state.image != null
                                            ? CircleAvatar(
                                                radius: 50,
                                                backgroundImage: FileImage(
                                                  File(state.image!.path),
                                                ),
                                              )
                                            : profileState.tempProfilePictureUrl !=
                                                        null &&
                                                    profileState
                                                        .tempProfilePictureUrl!
                                                        .isNotEmpty
                                                ? CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage:
                                                        NetworkImage(profileState
                                                            .tempProfilePictureUrl!),
                                                  )
                                                : const CircleAvatar(
                                                    radius: 50,
                                                    child: Icon(Icons.person,
                                                        size: 50),
                                                  );
                                      },
                                    ),
                                    if (profileState.editMode)
                                      Positioned(
                                        bottom: 60,
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: AppColors.primaryColor,
                                          ),
                                          onPressed: () {
                                            _showImageSourceActionSheet(
                                              imagePickerContext,
                                              imagePickerState,
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  profileState.tempName ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  profileState.displayUserType(),
                                  style: const TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "12 ",
                                      style: TextStyle(
                                        color: AppColors.primaryTextColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Total Contributions",
                                      style: TextStyle(
                                        color: AppColors.primaryTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                // Column(
                                //   children: [
                                //     Text(
                                //       "1000",
                                //       style: TextStyle(
                                //         color: AppColors.primaryTextColor,
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //     Text(
                                //       "Followers",
                                //       style: TextStyle(
                                //         color: AppColors.primaryTextColor,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(width: 40),
                                // Column(
                                //   children: [
                                //     Text(
                                //       "1200",
                                //       style: TextStyle(
                                //         color: AppColors.primaryTextColor,
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //     Text(
                                //       "Following",
                                //       style: TextStyle(
                                //         color: AppColors.primaryTextColor,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.all(16),
                              children: [
                                ProfileDetail(
                                  title: 'Name',
                                  subtitle: profileState.tempName ?? "",
                                  onEditPressed: (value) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateTempName(
                                        state: profileState,
                                        name: value,
                                      ),
                                    );
                                  },
                                  editType: ProfileDetailEditType.textField,
                                  isOnEditMode: profileState.editMode,
                                ),
                                ProfileDetail(
                                  title: 'Username',
                                  subtitle: profileState.tempUsername ?? "",
                                  onEditPressed: (value) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateTempUsername(
                                        state: profileState,
                                        username: value,
                                      ),
                                    );
                                  },
                                  editType: ProfileDetailEditType.textField,
                                  isOnEditMode: profileState.editMode,
                                ),
                                ProfileDetail(
                                  title: 'Email',
                                  subtitle: profileState.tempEmail ?? "",
                                  onEditPressed: (value) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateTempEmail(
                                        state: profileState,
                                        email: value,
                                      ),
                                    );
                                  },
                                  editType: ProfileDetailEditType.textField,
                                  isOnEditMode: profileState.editMode,
                                ),
                                if (profileState
                                    .checkUserType(UserType.organization))
                                  ProfileDetail(
                                    title: 'Address',
                                    subtitle: profileState.tempAddress ?? "",
                                    onEditPressed: (value) {
                                      BlocProvider.of<ProfileBloc>(context).add(
                                        UpdateTempAddress(
                                          state: profileState,
                                          address: value,
                                        ),
                                      );
                                    },
                                    editType: ProfileDetailEditType.textField,
                                    isOnEditMode: profileState.editMode,
                                  ),
                                ProfileDetail(
                                  title: profileState
                                          .checkUserType(UserType.organization)
                                      ? 'Description'
                                      : 'Bio',
                                  subtitle: profileState.tempBio ?? "",
                                  onEditPressed: (value) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateTempBio(
                                        state: profileState,
                                        bio: value,
                                      ),
                                    );
                                  },
                                  editType: ProfileDetailEditType.textField,
                                  isOnEditMode: profileState.editMode,
                                ),

                                ProfileDetail(
                                  title: profileState
                                          .checkUserType(UserType.organization)
                                      ? 'Contact Number'
                                      : 'Phone Number',
                                  subtitle: profileState.tempPhoneNumber ?? "",
                                  onEditPressed: (value) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      UpdatePhoneNumber(
                                        state: profileState,
                                        phoneNumber: value.toString(),
                                      ),
                                    );
                                  },
                                  editType: ProfileDetailEditType.textField,
                                  isOnEditMode: profileState.editMode,
                                  keyboardType: TextInputType.phone,
                                ),
                                // ProfileDetailExpansionTile(
                                //   profileDetailType: ProfileDetailType.interests,
                                //   editMode: profileState.editMode,
                                // ),
                                if (profileState
                                    .checkUserType(UserType.volunteer))
                                  ProfileDetailExpansionTile(
                                    profileDetailType: ProfileDetailType.skills,
                                    editMode: profileState.editMode,
                                  ),
                                if (profileState
                                    .checkUserType(UserType.volunteer))
                                  ProfileDetailExpansionTile(
                                    profileDetailType:
                                        ProfileDetailType.volunteerActivities,
                                    editMode: profileState.editMode,
                                  ),
                                if (profileState
                                    .checkUserType(UserType.volunteer))
                                  ProfileDetailExpansionTile(
                                    profileDetailType:
                                        ProfileDetailType.availability,
                                    editMode: profileState.editMode,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, left: 60, right: 60, bottom: 60),
                                  child: CommonButton(
                                    backgroundColor: AppColors.primaryColor,
                                    borderColor: AppColors.primaryBorderColor,
                                    text: 'Logout',
                                    textColor: AppColors.primaryTextColor,
                                    onTap: () {
                                      BlocProvider.of<AuthBloc>(context).add(
                                        const LogoutEvent(),
                                      );
                                    },
                                    contentColor: AppColors.primaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
