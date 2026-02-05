import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:measurements/utils/app_colors.dart';

class AppTextField {
  TextEditingController textEditingController = TextEditingController();
  String? label;

  Widget textField(TextEditingController textEditingController, String? label) {
    return TextField(
      controller: textEditingController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors().c666666),
        floatingLabelStyle: TextStyle(color: AppColors().c464646, fontSize: 18),
        labelText: label,
        filled: true,
        fillColor: AppColors().cEAEAEA,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
