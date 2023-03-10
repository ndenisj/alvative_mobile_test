import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/common/store/store.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put<UserStore>(UserStore());
  }
}
