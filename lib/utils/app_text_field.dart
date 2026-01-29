import 'package:flutter/material.dart';

class AppTextField {
  TextEditingController textEditingController = TextEditingController();
  String? label;

  Widget textField( TextEditingController textEditingController, String? label) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF1F2F6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
