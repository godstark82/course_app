import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future loadingDialog(BuildContext context) async {
  return await showAdaptiveDialog(
    barrierColor: Colors.white.withOpacity(.5),
    context: context,
    builder: (context) => Material(
      color: Colors.transparent,
      child: PopScope(
        canPop: false,
        child: Center(
          child: Container(
            height: 135,
            width: 135,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitSpinningLines(
                  color: Colors.indigo,
                  size: 55,
                ),
                Text("Loading..."),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
