import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/app_colors.dart';
import 'package:volunteer_linker/features/profile/presentation/bloc/key_selection_bloc/keyword_selection_bloc.dart';
import '../../../../core/enums.dart';
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
    print("ProfilePage initState");
    print(
      context.read<ProfileBloc>().state,
    );
    context.read<ProfileBloc>().add(
          GetProfile(
            state: context.read<ProfileBloc>().state,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KeywordSelectionBloc>(
          create: (context) => KeywordSelectionBloc(),
        ),
        BlocProvider<ProfileDetailBloc>(
          create: (context) => ProfileDetailBloc(),
        ),
      ],
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, profileState) {},
        builder: (context, profileState) {
          return profileState.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors
                        .transparent, // Replace with AppColors.transparent
                    elevation: 0,
                    leading: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ), // Replace with AppColors.backgroundColor
                    actions: [
                      profileState.editMode
                          ? IconButton(
                              icon: const Icon(
                                Icons.check,
                                color: AppColors.backgroundColor,
                              ),
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context).add(
                                  ProfileEditModeChanged(
                                    state: profileState,
                                  ),
                                );

                                BlocProvider.of<ProfileBloc>(context).add(
                                  UpdateProfile(
                                    state: profileState,
                                    id: profileState.userId,
                                    name: 'Musse Gkel',
                                    email: 'musseg437@gmail.com',
                                    userType: UserType.volunteer,
                                    username: 'user_001',
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
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                "https://img.freepik.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3383.jpg?w=740",
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              profileState.user?.name ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              true ? "Volunteer" : "Organization",
                              style: TextStyle(
                                color: AppColors.primaryTextColor,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
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
                              subtitle: profileState.user?.name ?? "",
                              onEditPressed: (value) {},
                              editType: ProfileDetailEditType.textField,
                              isOnEditMode: profileState.editMode,
                            ),
                            ProfileDetail(
                              title: 'Username',
                              subtitle: profileState.user?.username ?? "",
                              onEditPressed: (value) {},
                              editType: ProfileDetailEditType.textField,
                              isOnEditMode: profileState.editMode,
                            ),
                            ProfileDetail(
                              title: 'Email',
                              subtitle: '',
                              onEditPressed: (value) {},
                              editType: ProfileDetailEditType.textField,
                              isOnEditMode: profileState.editMode,
                            ),
                            ProfileDetail(
                              title: 'Bio',
                              subtitle:
                                  'lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
                              onEditPressed: (value) {},
                              editType: ProfileDetailEditType.textField,
                              isOnEditMode: profileState.editMode,
                            ),
                            ProfileDetailExpansionTile(
                              profileDetailType: ProfileDetailType.interests,
                              editMode: profileState.editMode,
                            ),
                            ProfileDetailExpansionTile(
                              profileDetailType: ProfileDetailType.skills,
                              editMode: profileState.editMode,
                            ),
                            ProfileDetailExpansionTile(
                              profileDetailType:
                                  ProfileDetailType.volunteerActivities,
                              editMode: profileState.editMode,
                            ),
                            ProfileDetailExpansionTile(
                              profileDetailType: ProfileDetailType.availability,
                              editMode: profileState.editMode,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
