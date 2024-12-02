import 'package:flutter/material.dart';

final theme = ThemeData.light().copyWith(
  primaryColor: Colors.white70,
  // canvasColor: Colors.transparent,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white70,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white70),
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
  ),
);

const backendURL =
    "http://ec2-54-145-163-178.compute-1.amazonaws.com:8080";
