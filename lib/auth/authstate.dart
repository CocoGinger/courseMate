import 'package:CourseMate/auth/constants/app_constants.dart';
import 'package:CourseMate/models/user.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';

class AuthState extends ChangeNotifier {
  Client client = Client();
  Account account;
  bool _isLoggedIn;
  User _user;
  String _error;

  bool get isLoggedIn => _isLoggedIn;
  User get user => _user;
  String get error => _error;
  AuthState() {
    _init();
  }
  _init() {
    _isLoggedIn = false;
    _user = null;
    client
        .setEndpoint(AppConstants.endPoint)
        .setProject(AppConstants.projectId);
    account = Account(client);
    _checkLogin();
  }

  _checkLogin() async {
    try {
      _user = await getAccount();
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<User> getAccount() async {
    try {
      Response<dynamic> res = await account.get();
      if (res.statusCode == 200)
        return User.fromJson(res.data);
      else
        return null;
    } catch (e) {
      print(e);
    }
  }

  login(String email, String password) async {
    try {
      var result =
          await account.createSession(email: email, password: password);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  signUp(String name, String email, String password) async {
    try {
      var result =
          await account.create(email: email, password: password, name: name);
      print(result);
      return result;
    } catch (e) {
      print(e);
    }
  }
}

signUp(String name, String email, String password) {}
