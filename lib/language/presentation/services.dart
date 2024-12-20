import 'package:flutter/material.dart';
import 'package:language_translation/language/domain/use_cases.dart';


class LanguageProvider with ChangeNotifier {
  final TranslateTextUseCase translateTextUseCase;

  String _currentLanguage = 'en';
  Map<String, String> _staticTranslations = {};

  LanguageProvider(this.translateTextUseCase);

  String get currentLanguage => _currentLanguage;

  Future<void> changeLanguage(String languageCode, BuildContext context) async {
    _currentLanguage = languageCode;

    _staticTranslations = await translateTextUseCase.repository.loadStaticTranslations(languageCode, context);

    notifyListeners();
  }

  String translate(String key) => _staticTranslations[key] ?? key;

  Future<String> translateDynamicText(String text) async {
    return await translateTextUseCase.execute(text, _currentLanguage);
  }
}
