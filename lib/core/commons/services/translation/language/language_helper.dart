import 'package:flutter/material.dart';
import 'package:flutter_template/core/commons/services/translation/language/language_keys.dart';
import 'package:flutter_template/core/commons/services/translation/language/language_locales.dart';
import 'package:flutter_template/core/extension/translation_extension.dart';

class LanguageHelper {
  String mapLocaleToUI(
    String languageKey,
    BuildContext context,
  ) {
    switch (languageKey) {
      case LanguageKeys.english:
        return context.trl.language_english;
      case LanguageKeys.spanish:
        return context.trl.language_spanish;
      default:
        return context.trl.language_english;
    }
  }

  Locale mapLangKeyToLocale(String langKey) {
    switch (langKey) {
      case LanguageKeys.english:
        return LanguageLocales.english;
      case LanguageKeys.spanish:
        return LanguageLocales.spanish;
      default:
        return LanguageLocales.english;
    }
  }
}

final List<String> languagesListDefault = [
  LanguageKeys.english,
  LanguageKeys.spanish,
];
