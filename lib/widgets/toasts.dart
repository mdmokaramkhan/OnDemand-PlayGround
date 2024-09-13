import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showSuccessToast({
  required BuildContext context,
  String? tittle,
  String? description,
}) async {
  toastification.show(
    context: context.mounted ? context : context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    showProgressBar: false,
    title: Text(description ?? 'Success'),
    autoCloseDuration: const Duration(seconds: 5),
    animationDuration: const Duration(milliseconds: 200),
    primaryColor: Colors.green,
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    alignment: Alignment.topCenter,
  );
}