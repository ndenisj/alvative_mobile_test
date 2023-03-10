import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/common/widgets/button_widget.dart';
import 'package:mobile/common/widgets/header_widget.dart';
import 'package:mobile/pages/auth/register/controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: _size.height * 0.1,
        child: Center(
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: RichText(
              text: TextSpan(children: <InlineSpan>[
                TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: 'Login',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                ),
              ]),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              children: [
                buildHeader(
                  context: context,
                  size: 0.04,
                  header: 'Create new account',
                ),
                TextFormField(
                  controller: controller.nameCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Full name is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 15.h),
                TextFormField(
                  controller: controller.emailCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                ),
                SizedBox(height: 15.h),
                TextFormField(
                  obscureText: true,
                  controller: controller.passwordCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  text: 'Register',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (controller.registerFormKey.currentState!.validate()) {
                      await controller.register();
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
        ),
      ),
    );
  }
}
