// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart' hide FormData;
// import 'package:mobile/common/utils/loading.dart';
// import 'package:mobile/common/values/server.dart';
// import 'package:mobile/pages/auth/login/binding.dart';
// import 'package:mobile/pages/auth/login/view.dart';

// class HttpUtil {
//   static HttpUtil _instance = HttpUtil._internal();
//   factory HttpUtil() => _instance;

//   late Dio dio;
//   CancelToken cancelToken = new CancelToken();

//   HttpUtil._internal() {
//     // BaseOptions、Options、RequestOptions
//     BaseOptions options = BaseOptions(
//       baseUrl: SERVER_API_URL,
//       connectTimeout: const Duration(milliseconds: 10000),
//       receiveTimeout: const Duration(milliseconds: 5000),
//       headers: {},
//       contentType: 'application/json; charset=utf-8',
//       responseType: ResponseType.json,
//     );

//     dio = Dio(options);

//     (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
//         (HttpClient client) {
//       client.badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//       return client;
//     };

//     dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) {
//         return handler.next(options);
//       },
//       onResponse: (response, handler) {
//         return handler.next(response);
//       },
//       onError: (DioError e, handler) {
//         Loading.dismiss();
//         ErrorEntity eInfo = createErrorEntity(e);
//         onError(eInfo);
//         return handler.next(e);
//       },
//     ));
//   }

//   void onError(ErrorEntity eInfo) {
//     print('error.code -> ' +
//         eInfo.code.toString() +
//         ', error.message -> ' +
//         eInfo.message);
//     switch (eInfo.code) {
//       case 401:
//         Get.offAll(() => LoginPage(), binding: LoginBinding());
//         EasyLoading.showError(eInfo.message);
//         break;
//       default:
//         EasyLoading.showError('Error');
//         break;
//     }
//   }

//   ErrorEntity createErrorEntity(DioError error) {
//     switch (error.type) {
//       case DioErrorType.cancel:
//         return ErrorEntity(code: -1, message: "请求取消");
//       case DioErrorType.connectionTimeout:
//         return ErrorEntity(code: -1, message: "连接超时");
//       case DioErrorType.sendTimeout:
//         return ErrorEntity(code: -1, message: "请求超时");
//       case DioErrorType.receiveTimeout:
//         return ErrorEntity(code: -1, message: "响应超时");
//       case DioErrorType.cancel:
//         return ErrorEntity(code: -1, message: "请求取消");
//       case DioErrorType.badResponse:
//         {
//           try {
//             int errCode =
//                 error.response != null ? error.response!.statusCode! : -1;
//             // String errMsg = error.response.statusMessage;
//             // return ErrorEntity(code: errCode, message: errMsg);
//             switch (errCode) {
//               case 400:
//                 return ErrorEntity(code: errCode, message: "请求语法错误");
//               case 401:
//                 return ErrorEntity(code: errCode, message: "没有权限");
//               case 403:
//                 return ErrorEntity(code: errCode, message: "服务器拒绝执行");
//               case 404:
//                 return ErrorEntity(code: errCode, message: "无法连接服务器");
//               case 405:
//                 return ErrorEntity(code: errCode, message: "请求方法被禁止");
//               case 500:
//                 return ErrorEntity(code: errCode, message: "服务器内部错误");
//               case 502:
//                 return ErrorEntity(code: errCode, message: "无效的请求");
//               case 503:
//                 return ErrorEntity(code: errCode, message: "服务器挂了");
//               case 505:
//                 return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
//               default:
//                 {
//                   // return ErrorEntity(code: errCode, message: "未知错误");
//                   return ErrorEntity(
//                     code: errCode,
//                     message: error.response != null
//                         ? error.response!.statusMessage!
//                         : "",
//                   );
//                 }
//             }
//           } on Exception catch (_) {
//             return ErrorEntity(code: -1, message: "未知错误");
//           }
//         }
//       default:
//         {
//           return ErrorEntity(code: -1, message: error.message!);
//         }
//     }
//   }

//   ///
//   ///
//   Map<String, dynamic>? getAuthorizationHeader({String? token}) {
//     var headers = <String, dynamic>{};
//     if (token != null) {
//       headers['Authorization'] = 'Bearer $token';
//     }
//     return headers;
//   }

//   Future get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     String? token,
//     Options? options,
//     bool refresh = false,
//     bool noCache = false,
//     bool list = false,
//     String cacheKey = '',
//     bool cacheDisk = false,
//   }) async {
//     Options requestOptions = options ?? Options();
//     if (requestOptions.extra == null) {
//       requestOptions.extra = Map();
//     }
//     requestOptions.extra!.addAll({
//       "refresh": refresh,
//       "noCache": noCache,
//       "list": list,
//       "cacheKey": cacheKey,
//       "cacheDisk": cacheDisk,
//     });
//     requestOptions.headers = requestOptions.headers ?? {};
//     Map<String, dynamic>? authorization = getAuthorizationHeader(token: token);
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }

//     var response = await dio.get(
//       path,
//       queryParameters: queryParameters,
//       options: options,
//       cancelToken: cancelToken,
//     );
//     return response.data;
//   }

//   /// restful post 操作
//   Future post(
//     String path, {
//     dynamic data,
//     String? token,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//     Map<String, dynamic>? authorization = getAuthorizationHeader(token: token);
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//     var response = await dio.post(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );

//     return response.data;
//   }
// }

// class ErrorEntity implements Exception {
//   int code = -1;
//   String message = "";
//   ErrorEntity({required this.code, required this.message});

//   String toString() {
//     if (message == "") return "Exception";
//     return "Exception: code $code, $message";
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/common/values/server.dart';

class HttpUtils {
  final _client = http.Client();
  final _baseUrl = SERVER_API_URL;

  Future<Map<String, dynamic>> post({
    required body,
    required String endpoint,
    String token = "",
  }) async {
    try {
      var response = await _client.post(_buildUrl(endpoint: endpoint),
          body: body,
          headers: _httpHeader(
            token: token,
          ));
      var decodedRes = jsonDecode(response.body);

      // if (response.statusCode >= 400) {
      //   return _handleError(decodedRes['message'].toString());
      // }
      return decodedRes;
    } on SocketException {
      return _handleError('No Internet connection 😑');
    } on HttpException {
      return _handleError("Couldn't find the post 😱");
    } on FormatException {
      return _handleError("Bad response format 👎");
    }
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    String token = "",
  }) async {
    try {
      var response = await _client.get(_buildUrl(endpoint: endpoint),
          headers: _httpHeader(
            token: token,
          ));

      var decodedRes = jsonDecode(response.body);

      return decodedRes;
    } on SocketException {
      return _handleError('No Internet connection 😑');
    } on HttpException {
      return _handleError("Couldn't find the post 😱");
    } on FormatException {
      return _handleError("Bad response format 👎");
    }
  }

  Uri _buildUrl({required String endpoint}) {
    return Uri.parse(_baseUrl + endpoint);
  }

  Map<String, dynamic> _handleError(String errorMessage) {
    return {
      'status': false,
      'code': -1,
      'message': errorMessage,
      'data': null,
    };
  }

  Map<String, String> _httpHeader({
    String token = "",
  }) {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }
}
