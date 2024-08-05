import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/core/enums.dart';
import 'package:volunteer_linker/features/home_page/presentation/bloc/home_page_bloc.dart';
import 'package:volunteer_linker/features/map/presentation/pages/google_map_page.dart';
import 'package:volunteer_linker/features/opportunity/presentation/bloc/bloc/opportunity_attendance_bloc.dart';
import 'package:volunteer_linker/features/opportunity/presentation/bloc/opportunity_bloc.dart';
import 'package:volunteer_linker/features/opportunity/presentation/pages/post_opportunity_page.dart';
import 'package:volunteer_linker/features/opportunity/presentation/pages/posted_opportunities.dart';

import '../../../home_page/presentation/pages/home_page.dart';
import '../../../opportunity/presentation/pages/participants_page.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../bloc/auth_bloc.dart';
import 'login_page.dart';

class RoutingPage extends StatelessWidget {
  const RoutingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<OpportunityBloc>(
          create: (context) => OpportunityBloc(),
        ),
        BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(),
        ),
        BlocProvider<OpportunityAttendanceBloc>(
          create: (context) => OpportunityAttendanceBloc(),
        ),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.currentPage == CurrentPage.home) {
            context.read<ProfileBloc>().add(
                  GetProfile(
                    state: context.read<ProfileBloc>().state,
                    userId: state.user?.uid ?? "",
                  ),
                );
          }
        },
        builder: (context, state) {
          print("AuthBloc Current Page: ${state.currentPage}");
          print(
            "AuthBloc opportunityId: ${state.selectedOpportunityId}",
          );

          if (state.user != null) {
            if (state.currentPage == CurrentPage.postOpportunity) {
              return const PostOpportunity();
            } else if (state.currentPage == CurrentPage.selectLocation) {
              return GoogleMapPage();
            } else if (state.currentPage == CurrentPage.login) {
              return const LoginScreen();
            } else if (state.currentPage == CurrentPage.profile) {
              return const ProfilePage();
            } else if (state.currentPage == CurrentPage.home) {
              return const HomePage();
            } else if (state.currentPage == CurrentPage.postedOpportunities) {
              return const PostedOpportunities();
            } else if (state.currentPage == CurrentPage.participants) {
              return ParticipantsPage(
                opportunityId: state.selectedOpportunityId ?? "",
              );
            }
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
