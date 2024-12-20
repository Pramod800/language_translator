import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslationRemoteDataSource {
  final GoogleTranslator translator;

  TranslationRemoteDataSource() : translator = GoogleTranslator();

  Future<String> translateText(String text, String targetLanguage) async {
    final translation = await translator.translate(text, to: targetLanguage);
    return translation.text;
  }

  Future<Map<String, String>> loadStaticTranslations(String languageCode, BuildContext context) async {
    final jsonData = await DefaultAssetBundle.of(context).loadString('assets/translations/$languageCode.json');
    return Map<String, String>.from(jsonDecode(jsonData));
  }
}
