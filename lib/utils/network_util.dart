
class NetworkUtil {
  static final NetworkUtil _instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  Future<dynamic>? get() {
    return null;
    // return http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  }
}
