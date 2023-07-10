import 'package:fluttersqflite/utils/network_util.dart';

import '../models/user.dart';

class RestData {
  final NetworkUtil _networkUtil = NetworkUtil();
  static final BASE_URL = '';
  static final LOGIN_URL = BASE_URL + '/';

  Future<User> login(String username, String password) {
    return Future.value(User(username, password));
  }
}
