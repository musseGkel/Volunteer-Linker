import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 18),
      child: SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6941C6)),
          strokeWidth: 1.0,
        ),
      ),
    );
  }
}
