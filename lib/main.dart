import 'package:flutter/material.dart';
import 'controller.dart';
import 'model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NY Times Articles',
      home: ArticlesList(),
    );
  }
}

class ArticlesList extends StatefulWidget {
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final ArticleController _articleController = ArticleController();
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final articleList = await _articleController.fetchArticles();
    setState(() {
      articles = articleList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NY Times Most Popular Articles'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Implement the menu functionality here
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'refresh') {
                // refresh functionality here
              } else if (value == 'settings') {
                // settings screen here
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'refresh',
                  child: Text('Refresh'),
                ),
                PopupMenuItem(
                  value: 'settings',
                  child: Text('Settings'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
              child:ListTile(
                title: Column(
                  children: <Widget>[
                    Text(
                      articles[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10), // Add space between title and subtitle
                    Text(
                      articles[index].abstract,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns the text to the right
                  children: <Widget>[
                    Text(
                      'Published Date:',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      articles[index].publishedDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetails(article: articles[index]),
                    ),
                  );
                },
              )

          );
        },
      ),
    );
  }
}

class ArticleDetails extends StatelessWidget {
  final Article article;

  ArticleDetails({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(article.abstract),
      ),
    );
  }
}