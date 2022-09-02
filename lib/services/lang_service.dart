

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'locals/en_us.dart';
import 'locals/ru_ru.dart';

class LangService extends Translations {


  // Default locale
  static final locale = defLanguage("en");


  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final items = [
    'English',
    'Русский',
  ];

  static final langs = [
    'en',
    'ru',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ru', 'RU'),
  ];


  static Locale defLanguage(String code) {
    var index = langs.indexOf(code);
    return locales[index];
  }

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUs, // lang/en_us.dart
    'ru_RU': ruRU, // lang/ru_ru.dart
  };



  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    if (locale != null) {
       Get.updateLocale(locale);
      // DBService.to.setLanguage(lang);
    }
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.deviceLocale;
  }
}