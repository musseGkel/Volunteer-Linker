import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SubmitButton extends StatelessWidget {
  final bool isLogin;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  const SubmitButton({
    super.key,
    required this.isLogin,
    required this.controllerEmail,
    required this.controllerPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              isLogin
                  ? signInWithEmailAndPassword(context)
                  : createUserWithEmailAndPassword(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6941C6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            child: Text(
              isLogin ? 'Login' : 'Register',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
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
      ),
    );
  }
}
