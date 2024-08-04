import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/widgets/common_button.dart';
import '../bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  state.user?.email ?? "User email",
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 35, left: 60, right: 60, bottom: 60),
                  child: CommonButton(
                    backgroundColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryBorderColor,
                    text: "Logout",
                    textColor: AppColors.primaryTextColor,
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(const LogoutEvent());
                    },
                    contentColor: AppColors.primaryTextColor,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
