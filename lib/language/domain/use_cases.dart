import 'package:language_translation/language/domain/repository.dart';

class TranslateTextUseCase {
  final TranslationRepository repository;

  TranslateTextUseCase(this.repository);

  Future<String> execute(String text, String targetLanguage) async {
    final translation = await repository.translateText(text, targetLanguage);
    return translation.text;
  }
}
