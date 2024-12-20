import 'package:flutter/material.dart';
import 'package:language_translation/language/domain/entity.dart';

abstract class TranslationRepository {
  Future<Translation> translateText(String text, String targetLanguage);
  Future<Map<String, String>> loadStaticTranslations(String languageCode ,BuildContext context);
}
