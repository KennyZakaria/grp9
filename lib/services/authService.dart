import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/models/User.dart';
import 'package:app/core/constants.dart';

class AuthService {
  static const String apiUrl = '${URL}users';
  static User? currentUser;
  // Using in-memory storage instead of SharedPreferences
  static bool _isLoggedIn = false;
  static Map<String, String> _userData = {};

  // Login function
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    try {
      // Make the API call to get users
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode != 200) {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }

      // Parse the response body
      final List<dynamic> users = json.decode(response.body);

      // Check if the provided credentials match any user
      for (var userJson in users) {
        if ((userJson['login'] == username ||
                userJson['login'].toLowerCase() == username.toLowerCase()) &&
            userJson['password'] == password) {
          // Create a User object
          final user = User.fromJson(userJson);
          currentUser = user;
          // Store user session in memory
          _saveUserSession(user);
          return {
            'success': true,
            'message': 'Login successful',
            'user': {
              'fName': user.fName,
              'lName': user.lName,
              'login': user.login,
            },
          };
        }
      }
      // No matching user found
      return {'success': false, 'message': 'Invalid username or password'};
    } catch (e) {
      // Error occurred
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // Save user session to memory instead of SharedPreferences
  static void _saveUserSession(User user) {
    _isLoggedIn = true;
    _userData = {'fName': user.fName, 'lName': user.lName, 'login': user.login};
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _isLoggedIn;
  }

  // Get current user from memory
  static User? getCurrentUser() {
    print(currentUser?.fName);
    print(currentUser?.lName);
    print(currentUser?.login);
    return currentUser;
  }

  // Logout function
  static void logout() {
    _isLoggedIn = false;
    _userData = {};
    currentUser = null;
  }
}
