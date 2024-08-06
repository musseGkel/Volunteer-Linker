import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/constants/app_colors.dart';

import '../../../../core/enums.dart';
import '../../../../core/widgets/animated_toggle.dart';
import '../../../../core/widgets/common_textfield.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          state.isOnLogin() ? "Login" : "Register",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (state.isOnRegister())
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 35,
                            left: 40,
                            right: 40,
                          ),
                          child: CommonTextField(
                            label: "Name",
                            controller: _controllerName,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                          left: 40,
                          right: 40,
                        ),
                        child: CommonTextField(
                          label: "EMAIL",
                          controller: _controllerEmail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                          left: 40,
                          right: 40,
                        ),
                        child: CommonTextField(
                          label: "Password",
                          controller: _controllerPassword,
                        ),
                      ),
                      if (state.isOnRegister()) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 35,
                            left: 40,
                            right: 40,
                          ),
                          child: CommonTextField(
                            label: "Confirm Password",
                            controller: _controllerConfirmPassword,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 35,
                            left: 40,
                            right: 40,
                          ),
                          child: Text(
                            "I want to sign up as a:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                        AnimatedToggle(
                          values: const ['Volunteer', 'Charity'],
                          backgroundColor: Colors.grey[200]!,
                          buttonColor: AppColors.primaryColor,
                          textColor: AppColors.primaryTextColor,
                          onToggleCallback: (value) {
                            BlocProvider.of<AuthBloc>(context).add(
                              ToggleUserType(
                                userType: value == 0
                                    ? UserType.volunteer
                                    : UserType.organization,
                                state: state,
                              ),
                            );
                          },
                        ),
                      ],
                      if (state.errorMessage != '')
                        Column(
                          children: [
                            SizedBox(height: size.height * 0.04),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 45,
                                right: 45,
                              ),
                              child: Center(
                                child: ErrorMessage(
                                  errorMessage: state.errorMessage,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (state.isLoading)
                        Column(
                          children: [
                            SizedBox(height: size.height * 0.04),
                            const LoadingIndicator(),
                          ],
                        ),
                      SizedBox(height: size.height * 0.04),
                      SubmitButton(
                        isLogin: state.isOnLogin(),
                        controllerEmail: _controllerEmail,
                        controllerPassword: _controllerPassword,
                        controllerName: _controllerName,
                        controllerConfirmPassword: _controllerConfirmPassword,
                        state: state,
                      ),
                      SizedBox(height: size.height * 0.04),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            ToggleLoginEvent(state),
                          );
                        },
                        child: Text(
                          state.isOnLogin()
                              ? "Register Instead"
                              : "Login Instead",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
