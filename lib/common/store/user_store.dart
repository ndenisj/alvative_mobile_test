import 'package:get/get.dart';
import 'package:mobile/common/entities/user_response_entity.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // if logged in or not
  final _isLogin = false.obs;
  String token = '';
  // user profile
  final _profile = User().obs;

  bool get isLogin => _isLogin.value;
  User get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;
  set setIsLogin(login) => _isLogin.value = login;

  // saving token
  Future<void> setToken(String value) async {
    token = value;
  }

  // saving profile
  Future<void> saveProfile(User profile) async {
    _isLogin.value = true;
    _profile(profile);
  }
}
