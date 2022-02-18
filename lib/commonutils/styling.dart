import 'package:ti/commonutils/size_config.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Colors.teal;

  static final ThemeData currentTheme = ThemeData(
    primarySwatch: Colors.teal,
    primaryColor: Colors.teal[400],
    textTheme: currentTextTheme,
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: currentTextTheme,
  );

  static final TextTheme currentTextTheme = TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 3 * SizeConfig.textMultiplier,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 3 * SizeConfig.textMultiplier,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontSize: 3 * SizeConfig.textMultiplier,
    ),
    headline4: TextStyle(
      color: Colors.white,
      fontSize: 3 * SizeConfig.textMultiplier,
    ),
    headline5: TextStyle(
      color: Colors.white,
      fontSize: 3 * SizeConfig.textMultiplier,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 3 * SizeConfig.textMultiplier,
    ),
    subtitle1: TextStyle(
      color: Colors.teal,
      fontSize: 1.4 * SizeConfig.textMultiplier,
      fontWeight: FontWeight.bold,
      //height: 1.5,
    ),
    subtitle2: TextStyle(
      color: Colors.teal,
      fontSize: 1 * SizeConfig.textMultiplier,
      fontWeight: FontWeight.bold,
      height: 1.5,
    ),
    button: TextStyle(
      color: Colors.black,
      fontSize: 2.5 * SizeConfig.textMultiplier,
    ),
    bodyText1: TextStyle(
      color: Colors.teal,
      fontSize: 2 * SizeConfig.textMultiplier,
      //fontWeight: FontWeight.bold,
      height: 1.5,
    ),
    bodyText2: TextStyle(
      color: Colors.teal,
      fontSize: 2 * SizeConfig.textMultiplier,
      //fontWeight: FontWeight.bold,
      height: 1.5,
    ),
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline6: _titleLight,
    subtitle2: _subTitleLight,
    button: _buttonLight,
    headline4: _greetingLight,
    headline3: _searchLight,
    bodyText2: _selectedTabLight,
    bodyText1: _unSelectedTabLight,
  );

  static final TextTheme darkTextTheme = TextTheme(
    headline6: _titleDark,
    subtitle2: _subTitleDark,
    button: _buttonDark,
    headline4: _greetingDark,
    headline3: _searchDark,
    bodyText2: _selectedTabDark,
    bodyText1: _unSelectedTabDark,
  );

  //lightTheme
  static final TextStyle _titleLight = TextStyle(
    color: Colors.black,
    fontSize: 3.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subTitleLight = TextStyle(
    color: subTitleTextColor,
    fontSize: 2 * SizeConfig.textMultiplier,
    height: 1.5,
  );

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.black,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 2.0 * SizeConfig.textMultiplier,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 2.3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _selectedTabLight = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: Colors.grey,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  static final TextStyle _subTitleDark =
      _subTitleLight.copyWith(color: Colors.white70);

  static final TextStyle _buttonDark =
      _buttonLight.copyWith(color: Colors.black);

  static final TextStyle _greetingDark =
      _greetingLight.copyWith(color: Colors.black);

  static final TextStyle _searchDark =
      _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark =
      _selectedTabDark.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark =
      _selectedTabDark.copyWith(color: Colors.white70);
}
