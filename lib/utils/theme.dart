import 'package:flutter/material.dart';
import 'package:measurements/utils/app_colors.dart';

class ThemeClass {
  // ===== LIGHT THEME =====
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    primaryColor: AppColors().c1F2836,
    scaffoldBackgroundColor: AppColors().cEFEEED,

    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: AppColors().cFFFFFF,
    ),

    popupMenuTheme: PopupMenuThemeData(color: AppColors().cFFFFFF),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors().cFFFFFF,
      contentPadding: EdgeInsets.all(5),
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
      labelLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: "Poppins", color: AppColors().c464646),
      labelSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 11, fontFamily: "Poppins", color: AppColors().c464646),
      headlineSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, fontFamily: "Poppins", color: AppColors().c464646),
      bodySmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "Poppins", color: AppColors().c464646),
      titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, fontFamily: "Poppins", color: AppColors().c464646),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, fontFamily: "Poppins", color: AppColors().c464646),
      bodyLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, fontFamily: "Poppins", color: AppColors().c464646),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors().c1F2836),

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors().cFFFFFF),
      backgroundColor: AppColors().c1F2836,
      centerTitle: false,
    ),

    bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors().cFFFFFF),

    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue, selectionColor: Colors.blue[200], selectionHandleColor: Colors.blue),
  );

  // ===== DARK THEME =====
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    primaryColor: AppColors().c1F2836,
    scaffoldBackgroundColor: const Color(0xff0F172A),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff1E293B),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xff1E293B)),

    dialogTheme: const DialogThemeData(backgroundColor: Color(0xff1E293B)),

    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xff1E293B)),
  );
}
