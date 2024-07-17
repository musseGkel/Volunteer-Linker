import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../bloc/auth_bloc.dart';
import 'login_page.dart';

class RoutingPage extends StatelessWidget {
  const RoutingPage({super.key});

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
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.user != null) {
            return const ProfilePage();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
