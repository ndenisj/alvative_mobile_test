import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/apis/user_api.dart';
import 'package:mobile/common/entities/register_request_entity.dart';
import 'package:mobile/common/store/store.dart';
import 'package:mobile/common/styles/theme.dart';
import 'package:mobile/common/utils/http_utils.dart';
import 'package:mobile/pages/payment/binding.dart';
import 'package:mobile/pages/payment/view.dart';

import 'state.dart';

class RegisterController extends GetxController {
  final state = RegisterState();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future register() async {
    try {
      RegisterRequestEntity registerRequestEntity = RegisterRequestEntity(
        name: nameCtrl.text,
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: false,
      );

      var result = await UserAPI(HttpUtils())
          .Register(params: registerRequestEntityToJson(registerRequestEntity));

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
