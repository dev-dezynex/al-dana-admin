import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "",
          style: tsPoppins(size: 16, weight: FontWeight.w500, color: white),
        ),
      ),
      body: SafeArea(
        child: Ink(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [primary, primary2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.expand,
            children: [
              SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * .1),
                      SvgPicture.asset(
                        "assets/icons/ic_auth.svg",
                        width: Get.width * .3,
                        height: Get.height * .15,
                      ),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      SizedBox(
                          width: Get.width * .7,
                          child: Text(
                            'Please enter your username and\n password to verify',
                            textAlign: TextAlign.center,
                            style: tsPoppins(
                                color: white,
                                weight: FontWeight.w400,
                                size: 14),
                          )),
                      SizedBox(height: Get.height * .05),
                      Form(
                        key: formKeySignIn,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: SizedBox(
                            width: Get.width * .7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: controller.usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: tsPoppins(
                                      color: white,
                                      size: 14,
                                      weight: FontWeight.w400),
                                  validator: (value) =>
                                      (value != null && value.isNotEmpty)
                                          ? null
                                          : '*Required',
                                  decoration: InputDecoration(
                                    iconColor: textDark40,
                                    counterStyle: tsPoppins(
                                        color: textDark60,
                                        size: 14,
                                        weight: FontWeight.w400),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    labelText: 'Username',
                                    labelStyle: tsPoppins(
                                        color: textDark40,
                                        size: 14,
                                        weight: FontWeight.w400),
                                    border: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder:
                                        const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                    disabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: controller.passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  validator: (value) =>
                                      (value != null && value.isNotEmpty)
                                          ? null
                                          : '*Required',
                                  style: tsPoppins(
                                      color: white,
                                      size: 14,
                                      weight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    iconColor: textDark40,
                                    counterStyle: tsPoppins(
                                        color: textDark60,
                                        size: 14,
                                        weight: FontWeight.w400),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    labelText: 'Password',
                                    labelStyle: tsPoppins(
                                        color: textDark40,
                                        size: 14,
                                        weight: FontWeight.w400),
                                    border: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder:
                                        const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                    disabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: textDark20)),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: Get.height * .2,
                      ),
                      Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator(color: white)
                          : ElevatedButton(
                              onPressed: () {
                                if (formKeySignIn.currentState!.validate()) {
                                  controller.verifyUser();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: accent,
                                  shape: const CircleBorder()),
                              child: const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                            )),
                      SizedBox(
                        height: Get.height * .2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
