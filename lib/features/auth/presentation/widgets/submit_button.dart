import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/app_colors.dart';
import '../../../../core/widgets/common_button.dart';
import '../bloc/auth_bloc.dart';

class SubmitButton extends StatelessWidget {
  final bool isLogin;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final TextEditingController? controllerName;
  final TextEditingController controllerConfirmPassword;

  const SubmitButton({
    super.key,
    required this.isLogin,
    required this.controllerEmail,
    required this.controllerPassword,
    required this.controllerConfirmPassword,
    this.controllerName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 60, right: 60, bottom: 60),
      child: CommonButton(
        backgroundColor: AppColors.primaryColor,
        borderColor: AppColors.primaryBorderColor,
        text: isLogin ? 'Login' : 'Register',
        textColor: AppColors.primaryTextColor,
        onTap: () {
          isLogin
              ? signInWithEmailAndPassword(context)
              : createUserWithEmailAndPassword(context);
        },
        contentColor: AppColors.primaryTextColor,
      ),
    );
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: controllerEmail.text,
        password: controllerPassword.text,
      ),
    );
  }

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        email: controllerEmail.text,
        password: controllerPassword.text,
        confirmPassword: controllerConfirmPassword.text,
        name: controllerName!.text,
      ),
    );
  }
}
