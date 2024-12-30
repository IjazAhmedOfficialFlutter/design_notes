import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;


  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      EasyLoading.show(status: 'Signing up...'); // Show loading

      final AuthResponse response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      EasyLoading.dismiss();

      if (response.user != null) {
        return "Signup successful. Please verify your email.";
      }
      return "Signup failed, please try again.";
    } catch (e) {
      EasyLoading.dismiss();
      return "Error: ${e.toString()}";
    }
  }

  /// Sign In with Email and Password
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      EasyLoading.show(status: 'Signing in...');

      final AuthResponse response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      EasyLoading.dismiss();

      if (response.user != null) {
        return "Login successful";
      }
      return "Login failed, please try again.";
    } catch (e) {
      EasyLoading.dismiss();
      return "Error: ${e.toString()}";
    }
  }


  /// Forgot Password
  Future<String?> forgotPassword(String email) async {
    try {
      EasyLoading.show(status: 'Sending password reset email...'); // Show loading

      await _supabaseClient.auth.resetPasswordForEmail(email);

      EasyLoading.dismiss();
      return "Password reset email sent. Check your inbox.";
    } catch (e) {
      EasyLoading.dismiss();
      return "Error: ${e.toString()}";
    }
  }

  /// Sign Out
  Future<String?> signOut() async {
    try {
      EasyLoading.show(status: 'Signing out...'); // Show loading

      await _supabaseClient.auth.signOut();

      EasyLoading.dismiss();
      return "Sign-out successful";
    } catch (e) {
      EasyLoading.dismiss();
      return "Error: ${e.toString()}";
    }
  }

  /// Get Current User
  User? getCurrentUser() {
    return _supabaseClient.auth.currentUser;
  }
}
