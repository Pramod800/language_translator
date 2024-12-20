import 'package:flutter/material.dart';
import 'package:language_translation/language/presentation/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final availableLanguages = {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.translate('welcome')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: languageProvider.currentLanguage,
              items: availableLanguages.entries
                  .map(
                    (entry) => DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    ),
                  )
                  .toList(),
              onChanged: (selectedLanguage) {
                if (selectedLanguage != null) {
                  languageProvider.changeLanguage(selectedLanguage, context);
                }
              },
            ),
            const SizedBox(height: 20),
            Text(languageProvider.translate('hello')),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: languageProvider.translateDynamicText('Dynamic data example'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return Text(snapshot.data ?? '...');
              },
            ),
          ],
        ),
      ),
    );
  }
}
