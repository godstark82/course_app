import 'dart:developer';

import 'package:course_app/constants/color.dart';
import 'package:course_app/constants/utils/utils.dart';
import 'package:course_app/functions/login_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({
    super.key,
    required this.controller,
    required this.confirmationResult,
  });
  final PageController controller;
  final ConfirmationResult confirmationResult;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [
            Positioned(
              left: 30,
              right: 30,
              bottom: 30,
              // padding: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor.withOpacity(.8),
                ),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm the code\n',
                      style: TextStyle(
                        color: AppColors.primaryHighContrast,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: 329,
                      height: 56,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Pinput(
                            controller: otpController,
                            defaultPinTheme: PinTheme(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12))),
                            length: 6,
                          )),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: TextButton(
                        onPressed: () async {
                          printInfo(info: otpController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                          loadingDialog(context);
                          try {
                            FirebaseAuthentication().authenticateMe(
                                widget.confirmationResult, otpController.text);
                            
                          } catch (e) {
                            log(e.toString());
                            //
                          }
                          
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.whiteColor,
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resend  ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryHighContrast,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TimerCountdown(
                          spacerWidth: 0,
                          enableDescriptions: false,
                          colonsTextStyle: TextStyle(
                            color: AppColors.primaryHighContrast,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          timeTextStyle: TextStyle(
                            color: AppColors.primaryHighContrast,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          format: CountDownTimerFormat.minutesSeconds,
                          endTime: DateTime.now().add(
                            const Duration(
                              minutes: 2,
                              seconds: 0,
                            ),
                          ),
                          onEnd: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          widget.controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Text(
                          'A 6-digit verification code has been sent}',
                          style: TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
