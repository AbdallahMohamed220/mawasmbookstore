import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mawasmbookstore/exception/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  // String userName;
  // String userNameEmail;
  // String userEmail;
  // String userPassword;
  // String userAddress;
  // String userPhoneNumber;
  // String userId;
  // String userToken;
  // Auth({
  //   this.userId,
  //   this.userName,
  //   this.userEmail,
  //   this.userAddress,
  //   this.userPhoneNumber,
  //   this.userPassword,
  // });

  // bool isAuth = false;
  String _token;

  bool get isAuth {
    print('token');
    print(token != null);

    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signIn(String email, String password) async {
    var url =
        'https://mawasmbookstore.com/?rest_route=/simple-jwt-login/v1/auth';
    try {
      http.Response response = await http.post(
        url,
        body: {
          "email": email.toString(),
          "password": password,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException('خطأ فى البريد الالكترونى او كلمة المرور ');
      }
      _token = responseData['data']['jwt'];
      notifyListeners();
      final prefes = await SharedPreferences.getInstance();
      final userData = json.encode({
        'user_token': _token,
      });
      print(' token is : $_token');
      print(' userData : ${userData}');
      prefes.setString('userData', userData);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    var url =
        'https://mawasmbookstore.com/wp-json/wc/v2/customers/?consumer%20key=ck_c804ed805bfa25be8ecd694a27b46978ca64ade3&consumer%20secret=cs_5557320ab49daf46a277d8aeed995988d369f4c5';
    try {
      http.Response response = await http.post(
        url,
        body: {
          "username": name.toString(),
          "email": email.toString(),
          "password": password
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] != null) {
        throw HttpException(responseData['message']);
      } else {
        final prefes = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
        });

        prefes.setString('userData', userData);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefes = await SharedPreferences.getInstance();
    if (!prefes.containsKey('userData')) {
      print("resit is  ${!prefes.containsKey('userData')}");
      return false;
    }
    final extractData =
        json.decode(prefes.getString('userData')) as Map<String, dynamic>;

    _token = extractData['token'];

    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefes = await SharedPreferences.getInstance();
    prefes.clear();
  }
}
