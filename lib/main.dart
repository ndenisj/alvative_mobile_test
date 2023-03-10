import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile/global.dart';
import 'package:mobile/pages/auth/login/binding.dart';
import 'package:mobile/pages/auth/login/view.dart';

import 'common/styles/theme.dart';

Future<void> main() async {
  await Global.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 780),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Paystack',
        theme: buildLightTheme(context),
        home: const LoginPage(),
        builder: EasyLoading.init(),
        initialBinding: LoginBinding(),
      ),
    );
  }
}
