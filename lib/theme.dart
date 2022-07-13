import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';


ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    fontFamily: "Muli",
    appBarTheme: appBarTheme(1),
    cardColor: kTextColor,
    primaryColor: kCardColor,
    highlightColor: kThirdLightColor,
    canvasColor: kSecondaryLightColor,
    inputDecorationTheme: inputDecorationTheme(1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: kDarkBackgroundColor,
    colorScheme: ColorScheme.dark(),
    fontFamily: "Muli",
    appBarTheme: appBarTheme(2),
    cardColor: kCardColor,
    primaryColor: kTextColor,
    highlightColor: kCardColor,
    inputDecorationTheme: inputDecorationTheme(2),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData darkMessagesTheme() {
  return ThemeData(
    scaffoldBackgroundColor: kDarkBackgroundColor,
    colorScheme: ColorScheme.dark(),
    fontFamily: "Muli",
    appBarTheme: appBarTheme(2),
    cardColor: kCardColor,
    primaryColor: kTextColor,
    inputDecorationTheme: inputDecorationMessagesTheme(2),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme(int data) {
  return TextTheme(
    bodyText1: TextStyle(color: data == 1 ? kCardColor : kTextColor),
    bodyText2: TextStyle(color: data == 1 ? kTextColor : kCardColor),
  );
}

InputDecorationTheme inputDecorationTheme(int data) {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: kPrimaryColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

InputDecorationTheme inputDecorationMessagesTheme(int data) {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: kPrimaryColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  
    border: InputBorder.none,
  );
}

AppBarTheme appBarTheme(int data) {
  return AppBarTheme(
      color: data == 1 ? Colors.white : kDarkBackgroundColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: data == 1 ? Brightness.light : Brightness.dark),
      iconTheme: IconThemeData(color: data == 1 ? kCardColor : Colors.white),
      titleTextStyle: TextStyle(
          color: data == 1 ? kCardColor : Colors.white, fontSize: 18));
}
