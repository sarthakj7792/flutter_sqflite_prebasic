import 'package:fluttersqflite/data/rest_data.dart';

import '../../models/user.dart';

abstract class LoginPageContract {
  void onLoginsuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  late LoginPageContract _view;
  RestData api = RestData();
  LoginPagePresenter(this._view);

  doLogin(String username, String password) {
    api.login(username, password).then((user) {
      _view.onLoginsuccess(user);
    }).catchError((onError) => _view.onLoginError(onError.toString()));
  }
}
