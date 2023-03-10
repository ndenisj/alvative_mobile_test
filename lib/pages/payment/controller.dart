import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/apis/payment_api.dart';
import 'package:mobile/common/entities/pay_with_new_type_request_entity.dart';
import 'package:mobile/common/entities/pay_with_saved_card_entity.dart';
import 'package:mobile/common/entities/payment_init_response_entity.dart';
import 'package:mobile/common/entities/save_cards_entiry.dart';
import 'package:mobile/common/entities/verify_payment_entity.dart';
import 'package:mobile/common/store/store.dart';
import 'package:mobile/common/styles/theme.dart';
import 'package:mobile/common/utils/http_utils.dart';
import 'package:mobile/pages/payment/widget/payment_webview.dart';

class PaymentController extends GetxController {
  RxList<SavedCard> savedCards = <SavedCard>[].obs;
  Rx<PaymentInitResponseEntity> paymentInitResponseEntity =
      PaymentInitResponseEntity().obs;

  TextEditingController amountCtrl = TextEditingController();
  GlobalKey<FormState> paymentFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getSavedCareds();
  }

  /// Get user paystack charge authorization
  Future<void> getSavedCareds() async {
    try {
      EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );

      var result = await PaymentAPI(HttpUtils()).getSavedCards();

      if (result.status!) {
        EasyLoading.dismiss();
        savedCards.value = result.data!;
      } else {
        EasyLoading.dismiss();
      }
    } catch (e) {
      if (kDebugMode) {
        print(".....error $e");
      }
    }
  }

  Future<void> payWithSavedCard({required String authCode}) async {
    try {
      PayWithSavedCardRequestEntity payWithSavedCardRequestEntity =
          PayWithSavedCardRequestEntity(
        type: "PAYSTACK_CHARGE_CARD",
        email: UserStore.to.profile.email!,
        amount: int.parse(amountCtrl.text) * 100,
        authorizationCode: authCode,
      );

      EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: false,
      );

      var result = await PaymentAPI(HttpUtils()).initPayment(
          params: payWithSavedCardRequestEntityToJson(
              payWithSavedCardRequestEntity));

      if (result.status!) {
        await getSavedCareds();
        EasyLoading.dismiss();
        showSuccessSnackbar(
            message: "Payment of ${amountCtrl.text} successful");
        amountCtrl.clear();
      } else {
        EasyLoading.dismiss();
        showErrorSnackbar(message: result.message!);
      }
    } catch (e) {
      if (kDebugMode) {
        print(".....error with PAYSTACK_CHARGE_CARD $e");
      }
    }
  }

  Future<void> initNewPayment() async {
    try {
      PayWithNewTypeRequestEntity payWithNewTypeRequestEntity =
          PayWithNewTypeRequestEntity(
        type: "PAYSTACK",
        email: UserStore.to.profile.email!,
        amount: int.parse(amountCtrl.text) * 100,
      );

      EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: false,
      );

      var result = await PaymentAPI(HttpUtils()).initNewPayment(
          params:
              payWithNewTypeRequestEntityToJson(payWithNewTypeRequestEntity));

      if (result.status!) {
        // redirect to payment screen
        paymentInitResponseEntity.value = PaymentInitResponseEntity(
          data: result.data,
          message: result.message,
          status: result.status,
        );
        EasyLoading.dismiss();
        Get.to(() => PaymentWebView())!.whenComplete(() async {
          // vaerify payment;
          EasyLoading.show(
            indicator: CircularProgressIndicator(),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: false,
          );
          VerifyPaymentRequestEntity verifyPaymentRequestEntity =
              VerifyPaymentRequestEntity(
            type: "VERIFY_PAYSTACK",
            userId: UserStore.to.profile.id!,
            ref: result.data!.reference!,
          );
          var verifyResult = await PaymentAPI(HttpUtils()).initPayment(
              params:
                  verifyPaymentRequestEntityToJson(verifyPaymentRequestEntity));
          if (verifyResult.data!.status == 'success') {
            // get cards
            await getSavedCareds();
            EasyLoading.dismiss();
            showSuccessSnackbar(
                message: "Payment of ${amountCtrl.text} successful");
            amountCtrl.clear();
          } else {
            EasyLoading.dismiss();
            showErrorSnackbar(
                message: "Payment of ${amountCtrl.text} was not successful");
          }
        });
      } else {
        EasyLoading.dismiss();
        showErrorSnackbar(message: result.message!);
      }
    } catch (e) {
      if (kDebugMode) {
        print(".....error with PAYSTACK $e");
      }
    }
  }
}
