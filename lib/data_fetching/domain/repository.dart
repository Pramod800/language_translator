

import 'package:language_translation/data_fetching/data/model.dart';

abstract class PostRepository {
  Future<List<PostModel>> fetchPosts();
}
