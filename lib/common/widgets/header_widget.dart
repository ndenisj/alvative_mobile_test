import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildHeader(
    {required BuildContext context,
    required double size,
    required String header}) {
  var height = MediaQuery.of(context).size.height;
  return Column(
    children: [
      Text(
        header,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.teal,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: height * size),
    ],
  );
}
