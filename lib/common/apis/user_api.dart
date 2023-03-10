import 'package:mobile/common/entities/register_request_entity.dart';
import 'package:mobile/common/entities/user_response_entity.dart';
import 'package:mobile/common/utils/http_utils.dart';

class UserAPI {
  final HttpUtils _httpUtil;
  UserAPI(this._httpUtil);

  Future<UserAuthResponseEntity> Register({
    String? params,
  }) async {
    print("REQ ${params}");
    var response = await _httpUtil.post(
      endpoint: 'api/register',
      body: params,
    );
    print("RES ${response.toString()}");
    return UserAuthResponseEntity.fromJson(response);
  }

  Future<UserAuthResponseEntity> Login({
    String? params,
  }) async {
    print("REQ ${params}");
    var response = await _httpUtil.post(
      endpoint: 'api/login',
      body: params,
    );
    print("RES ${response.toString()}");
    return UserAuthResponseEntity.fromJson(response);
  }
}
