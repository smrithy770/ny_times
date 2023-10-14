import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

class ArticleController {
  Future<List<Article>> fetchArticles() async {
    final apiKey = 'MYfHxBJn0nYO0qSNDq2V26EPFCBnnCKJ';
    final url = Uri.parse(
        'https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      return List<Article>.from(results.map((article) => Article.fromJSON(article)));
    } else {
      throw Exception('Failed to load articles');
    }
  }
}