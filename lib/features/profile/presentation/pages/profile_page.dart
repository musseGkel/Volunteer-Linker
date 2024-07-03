import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/app_colors.dart';
import 'package:volunteer_linker/features/profile/presentation/bloc/key_selection_bloc/keyword_selection_bloc.dart';
import '../../../../core/enums.dart';
import '../bloc/profile_detail_bloc/profile_detail_bloc.dart';
import '../widgets/profile_detail.dart';
import '../widgets/profile_detail_expansion_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          leading:
              const Icon(Icons.arrow_back, color: AppColors.backgroundColor),
          actions: const [
            Icon(
              Icons.settings,
              color: AppColors.backgroundColor,
            ),
            SizedBox(width: 16),
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
                  colors: [AppColors.softGray, AppColors.secondaryTextColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        "https://via.placeholder.com/150"), // Replace with actual image URL
                  ),
                  SizedBox(height: 10),
                  Text(
                    "James Martin",
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
                    subtitle: 'Musse',
                    onEditPressed: (value) {},
                    editType: ProfileDetailEditType.textField,
                  ),
                  ProfileDetail(
                    title: 'Username',
                    subtitle: '',
                    onEditPressed: (value) {},
                    editType: ProfileDetailEditType.textField,
                  ),
                  ProfileDetail(
                    title: 'Email',
                    subtitle: '',
                    onEditPressed: (value) {},
                    editType: ProfileDetailEditType.textField,
                  ),
                  ProfileDetail(
                    title: 'Bio',
                    subtitle:
                        'lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
                    onEditPressed: (value) {},
                    editType: ProfileDetailEditType.textField,
                  ),
                  const ProfileDetailExpansionTile(
                    profileDetailType: ProfileDetailType.interests,
                    editMode: true,
                  ),
                  const ProfileDetailExpansionTile(
                    profileDetailType: ProfileDetailType.skills,
                    editMode: true,
                  ),
                  const ProfileDetailExpansionTile(
                    profileDetailType: ProfileDetailType.availability,
                    editMode: false,
                  ),
                  const ProfileDetailExpansionTile(
                    profileDetailType: ProfileDetailType.volunteerActivities,
                    editMode: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
