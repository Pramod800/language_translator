import 'package:dio/dio.dart';
import 'package:language_translation/data_fetching/data/model.dart';

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<PostModel>> fetchPosts() async {
    try {
      final dio = Dio();
      final response = await dio.get('$_baseUrl/posts');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } on DioException catch (e) {
      throw Exception('API error: ${e.message}');
    }
  }
}
