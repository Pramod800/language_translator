


import 'package:language_translation/data_fetching/data/data_source.dart';
import 'package:language_translation/data_fetching/data/model.dart';
import 'package:language_translation/data_fetching/domain/repository.dart';

class PostRepositoryImpl implements PostRepository {
  @override
  Future<List<PostModel>> fetchPosts() async {
    return await PostService.fetchPosts();
  }
}
