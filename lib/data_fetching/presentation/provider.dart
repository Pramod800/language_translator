import 'package:flutter/material.dart';
import 'package:language_translation/data_fetching/data/model.dart';
import 'package:language_translation/data_fetching/domain/repository.dart';
import 'package:language_translation/language/presentation/services.dart';

class PostProvider with ChangeNotifier {
  final PostRepository _repository;
  final LanguageProvider _languageProvider;

  List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _error;

  PostProvider(this._repository, this._languageProvider) {
    _languageProvider.addListener(_onLanguageChanged);
  }

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _posts = await _repository.fetchPosts();
      await _translatePosts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _translatePosts() async {
    try {
      for (var i = 0; i < _posts.length; i++) {
        final translatedTitle =
            await _languageProvider.translateDynamicText(_posts[i].title);
        final translatedBody =
            await _languageProvider.translateDynamicText(_posts[i].body);

        _posts[i] = _posts[i].copyWith(
          title: translatedTitle,
          body: translatedBody,
        );
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void _onLanguageChanged() {
    _translatePosts();
  }

  @override
  void dispose() {
    _languageProvider.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void updatePost(int id, PostModel updatedPost) {
    final index = _posts.indexWhere((post) => post.id == id);
    if (index != -1) {
      _posts[index] = _posts[index].copyWith(
        title: updatedPost.title,
        body: updatedPost.body,
      );
      notifyListeners();
    }
  }
}
