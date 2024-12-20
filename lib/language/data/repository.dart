import 'package:flutter/material.dart';
import 'package:language_translation/language/data/data_source.dart';
import 'package:language_translation/language/domain/entity.dart';
import 'package:language_translation/language/domain/repository.dart';

class TranslationRepositoryImpl implements TranslationRepository {
  final TranslationRemoteDataSource remoteDataSource;

  TranslationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Translation> translateText(String text, String targetLanguage) async {
    final translatedText = await remoteDataSource.translateText(text, targetLanguage);
    return Translation(translatedText);
  }

  @override
  Future<Map<String, String>> loadStaticTranslations(String languageCode, BuildContext context) async {
    return remoteDataSource.loadStaticTranslations(languageCode, context);
  }
}
