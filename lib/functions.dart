// ignore_for_file: unused_import

import 'package:vks/pages/splash_page.dart';
import 'package:vks/services/theme_service.dart';
import 'package:flutter/material.dart';

Widget hgh(double height) {
  return SizedBox(height: height);
}

Widget wdt(double width) {
  return SizedBox(width: width);
}

String formatFirebaseAuthExceptionCode(String code) {
  return code.replaceAll('-', ' ').replaceFirst(code[0], code[0].toUpperCase());
}

Future<T> showLoadingDialog<T>(
    {required BuildContext context, required Future<T> task}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        task.then((value) {
          Future.delayed(
              const Duration(seconds: 3), () => Navigator.pop(context, value));
        });
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox.fromSize(
              size: const Size(100, 100),
              child: const Center(child: CircularProgressIndicator())),
        );
      });
}

Future<bool?> showYesNoDialog(
    {required BuildContext context, String message = ''}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text(message), actions: [
          TextButton(
            child: const Text('HAYIR'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          ElevatedButton(
            child: const Text('EVET'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ]);
      });
}
