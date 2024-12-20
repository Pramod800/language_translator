import 'package:flutter/material.dart';
import 'package:language_translation/data_fetching/data/repository.dart';
import 'package:language_translation/data_fetching/presentation/provider.dart';
import 'package:language_translation/language/data/data_source.dart';
import 'package:language_translation/language/data/repository.dart';
import 'package:language_translation/language/domain/repository.dart';
import 'package:language_translation/language/domain/use_cases.dart';
import 'package:language_translation/language/presentation/homepage.dart';
import 'package:language_translation/language/presentation/services.dart';
import 'package:provider/provider.dart';

void main() {
  final remoteDataSource = TranslationRemoteDataSource();
  final repository = TranslationRepositoryImpl(remoteDataSource);
  final translateTextUseCase = TranslateTextUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(translateTextUseCase),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        return MultiProvider(
          providers: [
           ChangeNotifierProvider(
              create: (_) => PostProvider(PostRepositoryImpl(), LanguageProvider(TranslateTextUseCase(TranslationRepositoryImpl(
                            TranslationRemoteDataSource()))))
            ),
           
          ],
          child: MaterialApp(
            locale: Locale(languageProvider.currentLanguage),
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}
