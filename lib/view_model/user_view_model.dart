import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(Map<String, dynamic> user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setString('token', user.data.token);
    sp.setString('user', jsonEncode(user));
    notifyListeners();
    return true;
  }

  Future<bool> saveToken(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setString('token', user.data.token);
    sp.setString('token', token);
    notifyListeners();
    return true;
  }

  Future<User?> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? userJson = sp.getString('user');
    if (userJson == null) {
      return null;
    }
    try {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return User.fromJson(userMap);
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding user JSON: $e');
      }
      return null;
    }
  }

  Future<String?> getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? tokenJson = sp.getString('token');
    if (tokenJson == null) {
      return null;
    }
    return tokenJson;
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('user');
    return true;
  }
}
