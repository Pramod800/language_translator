import 'package:flutter/material.dart';
import 'package:language_translation/data_fetching/data/model.dart';
import 'package:language_translation/data_fetching/presentation/provider.dart';
import 'package:language_translation/language/presentation/language_list.dart';
import 'package:language_translation/language/presentation/services.dart';
import 'package:provider/provider.dart';

class PostListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          DropdownButton<String>(
            value: languageProvider.currentLanguage,
            items: languageList.entries
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
        ],
      ),
      body: postProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : postProvider.error != null
              ? Center(child: Text('Error: ${postProvider.error}'))
              : ListView.builder(
                  itemCount: postProvider.posts.length,
                  itemBuilder: (context, index) {
                    final post = postProvider.posts[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => postProvider.fetchPosts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}



// void _editPost(BuildContext context, PostModel post) {
//   final postProvider = Provider.of<PostProvider>(context, listen: false);
//   final updatedPost = post.copyWith(
//     title: post.title + " (Edited)",
//   );
//   postProvider.updatePost(post.id, updatedPost);
// }
