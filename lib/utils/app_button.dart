import 'package:flutter/material.dart';
import 'package:measurements/utils/app_colors.dart';

class AppButton {
  Widget appButton(String label, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors().c1F5F8B, borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget outlinedButton(String label, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColors().c1F5F8B),
        color: AppColors().cFFFFFF,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: AppColors().c1F5F8B, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
