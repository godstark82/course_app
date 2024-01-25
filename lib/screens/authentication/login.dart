// ignore_for_file: use_build_context_synchronously

import 'package:course_app/constants/color.dart';
import 'package:course_app/functions/login_functions.dart';
import 'package:course_app/screens/authentication/verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final PageController controller;
  static ConfirmationResult? confirmationResult;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String fullPhoneNumber = '';
  final formKey = GlobalKey<FormState>();
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [
            const Positioned(
                left: 25,
                top: 25,
                child: Text("Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ))),
            const Positioned(
              left: 27,
              top: 65,
              child: Text("to Notepediax",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: Colors.grey)),
            ),
            Positioned(
              // padding: const EdgeInsets.all(30),
              bottom: 30,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor.withOpacity(.8),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    // padding: const EdgeInsets.symmetric(horizontal: 50),
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                          color: AppColors.primaryHighContrast,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IntlPhoneField(
                        decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder()),
                        initialCountryCode: 'IN',
                        onChanged: (value) {
                          fullPhoneNumber = value.completeNumber;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.whiteColor,
                            ),
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final temp = await FirebaseAuthentication()
                                  .sendOtp(fullPhoneNumber);
                              
                              LoginScreen.confirmationResult = temp;
                              Get.to(() => VerifyScreen(
                                  controller: widget.controller,
                                  confirmationResult: temp));
                            },
                            child: const Text("Sign In")),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
