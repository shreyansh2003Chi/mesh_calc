import 'package:flutter/material.dart';
import 'package:measurements/utils/app_colors.dart';

class ThemeClass {
  Color lightPrimaryColor = const Color(0xffffffff);
  Color darkPrimaryColor = const Color(0xff1f2836);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: _themeClass.lightPrimaryColor,
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: AppColors().cFFFFFF,
    ),
    popupMenuTheme: PopupMenuThemeData(color: AppColors().cFFFFFF),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors().cFFFFFF,
      contentPadding: const EdgeInsets.all(5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors().cDFDEDE, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors().cDFDEDE, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors().cDFDEDE, width: 1),
      ),
      hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: "Poppins", color: AppColors().cB6B6B6),
    ),
    textTheme: TextTheme(
      labelLarge: const TextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: "Poppins", color: AppColors().c464646),
      labelSmall: const TextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 11, fontFamily: "Poppins", color: AppColors().c464646),
      headlineSmall: const TextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 24, fontFamily: "Poppins", color: AppColors().c464646),
      bodySmall: const TextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "Poppins", color: AppColors().c464646),
      titleMedium: const TextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 18, fontFamily: "Poppins", color: AppColors().c464646),
      titleLarge: const TextStyle().copyWith(fontWeight: FontWeight.w600, fontSize: 20, fontFamily: "Poppins", color: AppColors().c464646),
      bodyLarge: const TextStyle().copyWith(fontWeight: FontWeight.w600, fontSize: 16, fontFamily: "Poppins", color: AppColors().c464646),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors().c1F2836),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      backgroundColor: AppColors().c1F2836,
      centerTitle: false,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors().cFFFFFF),
    scaffoldBackgroundColor: AppColors().cEFEEED,
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue, selectionColor: Colors.blue[200], selectionHandleColor: Colors.blue),
  );
}

ThemeClass _themeClass = ThemeClass();
