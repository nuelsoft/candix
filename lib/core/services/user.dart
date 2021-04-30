import '_api.dart';

class UserService extends API {
  Future<NetworkResponse> login(email, password) async {
    return parse(
        await post(uri("auth/login"), {"email": email, "password": password}));
  }
}
