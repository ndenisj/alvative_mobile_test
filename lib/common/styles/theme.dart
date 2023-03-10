import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Theme
ThemeData buildLightTheme(BuildContext context) {
  return ThemeData(primarySwatch: Colors.teal, brightness: Brightness.light)
      .copyWith(
    inputDecorationTheme: _buildLightInputDecorationTheme(context),
  );
}

InputDecorationTheme _buildLightInputDecorationTheme(BuildContext context) {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
    errorMaxLines: 1,
    hintStyle: Theme.of(context).textTheme.bodySmall,
    labelStyle: Theme.of(context).textTheme.bodySmall,
    errorStyle:
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),
    // borders
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    // prefix
    prefixIconColor: Colors.teal,
    prefixStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 18,
        ),
    // surfix
    suffixIconColor: Theme.of(context).primaryColor,
  );
}

const backgroundGradient = LinearGradient(
  begin: Alignment(-1.0, -0.0),
  end: Alignment(1.0, 0.0),
  colors: [
    Color(0xFFFFEDE6),
    Color(0xFFE7EFEB),
  ],
);

showErrorSnackbar({required String message}) {
  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    title: 'Error',
    message: message,
    icon: Icon(Icons.warning),
    duration: Duration(seconds: 3),
    isDismissible: false,
    backgroundColor: Colors.red,
  );
}

showSuccessSnackbar({required String message}) {
  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    title: 'Success',
    message: message,
    icon: Icon(Icons.check),
    duration: Duration(seconds: 3),
    isDismissible: false,
    backgroundColor: Colors.green,
  );
}
