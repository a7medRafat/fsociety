import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';

ThemeData LightTheme  = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18.0
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 12.0,
    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 27
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      backwardsCompatibility: false,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 20.0,
      selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16
      ),
      selectedIconTheme: IconThemeData(
          size: 25.0
      ),
      selectedItemColor: defaultColor,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey
  ),
  fontFamily: 'romans',

);

ThemeData DarkTheme  = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18.0
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 12.0,
    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 27
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      backwardsCompatibility: false,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark

      )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 20.0,
      selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16
      ),
      selectedIconTheme: IconThemeData(
          size: 25.0
      ),
      selectedItemColor: Colors.deepOrange,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey
  ),
  fontFamily: 'roman',

);