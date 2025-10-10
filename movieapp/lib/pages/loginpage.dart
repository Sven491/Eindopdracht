import 'package:MovieList/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  // Login functie
  Future<String?> onLogin(LoginData data) async {
    try {
      final response = await _authService.signInWithEmailPassword(data.name, data.password);
      if (response.session == null) {
        return 'Login failed: Invalid credentials or unknown error';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Recovery password
  Future<String?> onRecoverPassword(String email) async {
    try {
    await Supabase.instance.client.auth.resetPasswordForEmail(email);
    return null; // Success, email sent
  } catch (e) {
    return e.toString();
  }
}

  //Signup functie
  Future<String?> onSignup(SignupData data) async { 
    try {
      final response = await _authService.signUpWithEmailPassword(
        data.name ?? '',
        data.password ?? '',
      );
      if (response.user == null) {
        return 'Login failed: Invalid credentials or unknown error';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        onLogin: onLogin,
        onRecoverPassword: onRecoverPassword,
        onSignup: onSignup,
        onSubmitAnimationCompleted: () {
          Navigator.pushReplacementNamed(context, '/main');
        },
        ),
    );
  }
}
