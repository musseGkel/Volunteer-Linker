import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/app_colors.dart';
import '../../../../core/enums.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class CustomDrawer extends StatelessWidget {
  final AuthState authState;
  final Function(CurrentPage, AuthState) onItemTapped;

  const CustomDrawer({
    Key? key,
    required this.authState,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            String? profilePictureUrl;
            if (profileState.tempUserType == UserType.volunteer) {
              profilePictureUrl = profileState.user?.profilePictureUrl ?? "";
            } else if (profileState.tempUserType == UserType.organization) {
              profilePictureUrl =
                  profileState.organization?.profilePictureUrl ?? "";
            }

            String name = profileState.user?.userType == UserType.volunteer
                ? profileState.user?.name ?? 'Guest User'
                : profileState.organization?.name ?? 'Guest Organization';

            String email = profileState.user?.userType == UserType.volunteer
                ? profileState.user?.email ?? 'No email available'
                : profileState.organization?.email ?? 'No email available';

            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(ChangePageEvent(
                          state: authState, changePage: CurrentPage.profile));
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: AppColors.accentColor,
                      ),
                      accountName: Text(
                        name,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                      accountEmail: Text(
                        email,
                        style: const TextStyle(color: AppColors.primaryColor),
                      ),
                      currentAccountPicture: profilePictureUrl != null &&
                              profilePictureUrl.isNotEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: CachedNetworkImageProvider(
                                profileState.tempProfilePictureUrl!,
                              ),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              child: Icon(
                                Icons.person,
                                size: 50,
                              ),
                            ),
                    ),
                  ),
                  ListTile(
                    selected: authState.isCurrentPage(CurrentPage.home),
                    leading: Icon(
                      Icons.home,
                      size: authState.isCurrentPage(CurrentPage.home) ? 30 : 24,
                    ),
                    title: const Text('Home'),
                    onTap: () => onItemTapped(CurrentPage.home, authState),
                  ),
                  if (profileState.tempUserType == UserType.organization)
                    ListTile(
                      selected:
                          authState.isCurrentPage(CurrentPage.postOpportunity),
                      leading: Icon(
                        Icons.post_add,
                        size:
                            authState.isCurrentPage(CurrentPage.postOpportunity)
                                ? 30
                                : 24,
                      ),
                      title: const Text('Post Opportunity'),
                      onTap: () =>
                          onItemTapped(CurrentPage.postOpportunity, authState),
                    ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: authState.isCurrentPage(CurrentPage.profile)
                          ? 30
                          : 24,
                    ),
                    title: const Text('Profile'),
                    onTap: () => onItemTapped(
                      CurrentPage.profile,
                      authState,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.image,
                      size: authState
                              .isCurrentPage(CurrentPage.postedOpportunities)
                          ? 30
                          : 24,
                    ),
                    title: const Text('Posted Opportunities'),
                    onTap: () => onItemTapped(
                      CurrentPage.postedOpportunities,
                      authState,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
