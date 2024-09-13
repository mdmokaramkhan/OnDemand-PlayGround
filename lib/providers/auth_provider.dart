import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final Dio _dio = Dio();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(
      String username, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.post(
        'https://api-demo-bice.vercel.app/api/login', // Replace with your API endpoint
        data: {
          'email': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful login, e.g., save token, navigate to the next screen
        if (response.data['msg'] == 'Logged in Successfully') {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('email', username);
          pref.setString('password', password);
          pref.setBool('isLogged', true);
          if (context.mounted) context.push('/home');
        } else {
          _errorMessage = response.data['msg'];
        }
      } else {
        _errorMessage = 'Login failed. Please try again.';
      }
    } on DioException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('password');
    preferences.remove('isLogged');
    if (context.mounted) context.go('/sign-in');
  }

}
