import 'package:mobile/common/entities/payment_init_response_entity.dart';
import 'package:mobile/common/entities/payment_response_entity.dart';
import 'package:mobile/common/entities/save_cards_entiry.dart';
import 'package:mobile/common/store/store.dart';
import 'package:mobile/common/utils/http_utils.dart';

class PaymentAPI {
  final HttpUtils _httpUtil;
  PaymentAPI(this._httpUtil);

  Future<SavedCardsEntity> getSavedCards() async {
    var response = await _httpUtil.get(
      endpoint: 'api/payment/cards',
      token: UserStore.to.token,
    );
    print("RES ${response.toString()}");
    return SavedCardsEntity.fromJson(response);
  }

  Future<PaymentResponseEntity> initPayment({
    String? params,
  }) async {
    print("REQ ${params}");
    var response = await _httpUtil.post(
      endpoint: 'api/payment',
      body: params,
      token: UserStore.to.token,
    );
    print("RES ${response.toString()}");
    return PaymentResponseEntity.fromJson(response);
  }

  Future<PaymentInitResponseEntity> initNewPayment({
    String? params,
  }) async {
    print("REQ ${params}");
    var response = await _httpUtil.post(
      endpoint: 'api/payment',
      body: params,
      token: UserStore.to.token,
    );
    print("RES ${response.toString()}");
    return PaymentInitResponseEntity.fromJson(response);
  }
}
