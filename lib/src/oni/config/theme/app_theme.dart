import 'package:flutter/material.dart';

class AppTheme {

  Color colorCalendarText = const Color(0xFF1D1D1D);
  Color whiteColor = const Color(0xFFFAC55F);
  Color primaryColor = const Color(0xFFFAC55F);
  Color primaryColor2 = const Color(0xFFFCB61A);
  Color secondColor = const Color(0xFF1D1D1D);
  Color threeColor = const Color(0xFFA4C2C0);
  Color fourColor = const Color(0xFF313131);
  Color fiveColor = const Color(0xFF191919);
  Color textColor = const Color(0xFFD1D1D1);
  Color focusColor = const Color(0xFF707070);
  Color dangerColor = const Color(0xFFE9514C);
  Color dangerColor2 = const Color(0xFFED271B);
  Color blueLightColor = const Color(0xFFA4C2C0);
  Color textColorWhite = const Color(0xFFFFFFFF);

  ThemeData theme() {
    return ThemeData(
      colorSchemeSeed: primaryColor,
      scaffoldBackgroundColor: const Color(0xff313131),
      brightness: Brightness.dark,
      
    );
  }
}
