import 'package:flutter/material.dart';

class ConfigLanguage {
  static List<Locale> supportedLocales = [
    Locale('zh', 'CN'),
    Locale('en', 'US'),
  ];

  static Map<String, dynamic> sopportLanguage = {
    "zh": {"code": "zh", "country_code": "CN"},
    "en": {"code": "en", "country_code": "US"}
  };

  static dynamic defualtLanguage = {
    "code": "zh",
    "country_code": "CN"
  };
}