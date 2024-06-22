import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/common_textfield.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/entry_field.dart';
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
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      state.isLogin ? "Login" : "Register",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
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
                  if (state.errorMessage != '')
                    Column(
                      children: [
                        SizedBox(height: size.height * 0.04),
                        ErrorMessage(
                          errorMessage: state.errorMessage,
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
                    isLogin: state.isLogin,
                    controllerEmail: _controllerEmail,
                    controllerPassword: _controllerPassword,
                  ),
                  SizedBox(height: size.height * 0.04),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        ToggleLoginEvent(state),
                      );
                    },
                    child: Text(
                      state.isLogin ? "Register Instead" : "Login Instead",
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
        );
      },
    );
  }
}
