import 'package:CourseMate/auth/constants/app_constants.dart';
import 'package:CourseMate/models/user.dart';
import 'package:CourseMate/utils/routes.dart';
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
      if (res.statusCode == 200) {
        return User.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    try {
      Response result = await account.deleteSession(sessionId: 'current');
      print(result);
    } catch (e) {}
  }

  Future login(String email, String password) async {
    try {
      Response result =
          await account.createSession(email: email, password: password);
      return result;
    } catch (e) {
      _error = e;
    }
  }

  Future signUp(String name, String email, String password) async {
    try {
      var result =
          await account.create(email: email, password: password, name: name);
      if (result.statusCode == 200) login(email, password);
    } catch (e) {
      _error = e;
    }
  }
}
