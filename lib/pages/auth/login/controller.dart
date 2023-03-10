import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/apis/user_api.dart';
import 'package:mobile/common/entities/login_request_entity.dart';
import 'package:mobile/common/store/store.dart';
import 'package:mobile/common/styles/theme.dart';
import 'package:mobile/common/utils/http_utils.dart';
import 'package:mobile/pages/payment/binding.dart';
import 'package:mobile/pages/payment/view.dart';

import 'state.dart';

class LoginController extends GetxController {
  final state = LoginState();

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future login() async {
    try {
      LoginRequestEntity loginRequestEntity = LoginRequestEntity(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: false,
      );

      var result = await UserAPI(HttpUtils())
          .Login(params: loginRequestEntityToJson(loginRequestEntity));

      if (result.status!) {
        await UserStore.to.saveProfile(result.data!.user!);
        await UserStore.to.setToken(result.data!.token!);
        EasyLoading.dismiss();
        Get.offAll(() => PaymentPage(), binding: PaymentBinding());
      } else {
        EasyLoading.dismiss();
        showErrorSnackbar(message: result.message!);
      }
    } catch (e) {
      if (kDebugMode) {
        print(".....error with register $e");
      }
    }
  }
}
