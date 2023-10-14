class Article {
  final String title;
  final String abstract;
  final String publishedDate;

  Article({
    required this.title,
    required this.abstract,
    required this.publishedDate,
  });

  factory Article.fromJSON(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Title Not Available',
      abstract: json['abstract'] ?? 'Abstract Not Available',
      publishedDate: json['published_date'] ?? 'Date Not Available',
    );
  }
}
