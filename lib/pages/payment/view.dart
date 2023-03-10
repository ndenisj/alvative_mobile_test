import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/common/store/store.dart';
import 'package:mobile/common/styles/theme.dart';
import 'package:mobile/common/utils/assets.dart';
import 'package:mobile/common/widgets/button_widget.dart';
import 'package:mobile/pages/payment/controller.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Paystack"),
        centerTitle: true,
      ),
      body: Form(
        key: controller.paymentFormKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Text("${UserStore.to.token}"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.amountCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Amount is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Amount ',
                      prefixIcon: Icon(Icons.currency_exchange),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    text: 'Process Payment ',
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (controller.paymentFormKey.currentState!.validate()) {
                        await controller.initNewPayment();
                      }
                    },
                    options: ButtonOptions(
                      height: 40.h,
                      width: _size.width / 2,
                      textStyle: TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("OR"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 10.h),
            Obx(
              () => controller.savedCards.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 0.9,
                        height: _size.height * 0.24,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                      ),
                      items: controller.savedCards.map((payment) {
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () async {
                                FocusScope.of(context).unfocus();

                                if (controller.paymentFormKey.currentState!
                                    .validate()) {
                                  await controller.payWithSavedCard(
                                      authCode: payment.authorizationCode!);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: _size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: backgroundGradient,
                                  image: DecorationImage(
                                    image:
                                        AssetImage(ImageAssets.card_background),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "${payment.cardType}".toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w900,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: _size.height * 0.03),
                                    Text(
                                      "****   ****   ****   ${payment.last4}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    SizedBox(height: _size.height * 0.03),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "BANK",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 12,
                                                  ),
                                            ),
                                            Text(
                                              "${payment.bank}".toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "EXPIRES",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 12,
                                                  ),
                                            ),
                                            Text(
                                              "${payment.expMonth}/${payment.expYear!.substring(payment.expYear!.length - 2)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )
                  : Text(
                      'No saved card',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
