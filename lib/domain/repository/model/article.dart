import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  Article({
    required this.uuid,
    required this.title,
    required this.description,
    this.snippet,
    this.url,
    this.imageUrl,
    this.language,
    required this.publishedAt,
    this.source,
    this.categories,
    this.relevanceScore,
    this.locale,
  });
  final String uuid;
  final String title;
  final String description;
  final String? snippet;
  final String? url;

  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? language;

  @JsonKey(name: 'published_at')
  final String publishedAt;
  final String? source;
  final List<String>? categories;

  @JsonKey(name: 'relevance_score')
  final String? relevanceScore;
  final String? locale;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}