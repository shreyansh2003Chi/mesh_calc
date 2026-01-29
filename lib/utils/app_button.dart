import 'package:flutter/material.dart';
import 'package:measurements/utils/app_colors.dart';

class AppButton {
  Widget appButton(String label) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors().c5B2C2C, borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(label, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
