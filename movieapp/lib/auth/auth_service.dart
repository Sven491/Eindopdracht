import 'package:supabase_flutter/supabase_flutter.dart';

// Controle van inlog informatie
class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  //signin
  Future<AuthResponse> signInWithEmailPassword (
    String email,
    String password) async {
      return await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
  }

  //signup
  Future<AuthResponse> signUpWithEmailPassword (
    String email,
    String password) async {
      return await supabase.auth.signUp(
        email: email,
        password: password,
      );
  }

  //signout
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
  //user email
  String? getUserEmail() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}