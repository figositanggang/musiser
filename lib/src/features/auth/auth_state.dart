import 'package:flutter/material.dart';
import 'package:musiser/src/features/auth/page/login.dart';
import 'package:musiser/src/features/home/page/home_page.dart';
import 'package:musiser/src/helpers/auth_helper.dart';

class AuthState extends StatelessWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthHelper.auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material();
        }

        if (!snapshot.hasData) {
          return const LoginPage();
        }

        return const HomePage();
      },
    );
  }
}
