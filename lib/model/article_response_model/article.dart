import 'dart:convert';

import 'source.dart';

class Article {
	Source? source;
	String? author;
	String? title;
	String? description;
	String? url;
	String? urlToImage;
	String? publishedAt;
	String? content;

	Article({
		this.source, 
		this.author, 
		this.title, 
		this.description, 
		this.url, 
		this.urlToImage, 
		this.publishedAt, 
		this.content, 
	});

	@override
	String toString() {
		return 'Article(source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
	}

	factory Article.fromMap(Map<String, dynamic> data) => Article(
				source: data['source'] == null
						? null
						: Source.fromMap(data['source'] as Map<String, dynamic>),
				author: data['author'] as String?,
				title: data['title'] as String?,
				description: data['description'] as String?,
				url: data['url'] as String?,
				urlToImage: data['urlToImage'] as String?,
				publishedAt: data['publishedAt'] as String?,
				content: data['content'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'source': source?.toMap(),
				'author': author,
				'title': title,
				'description': description,
				'url': url,
				'urlToImage': urlToImage,
				'publishedAt': publishedAt,
				'content': content,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Article].
	factory Article.fromJson(String data) {
		return Article.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Article] to a JSON string.
	String toJson() => json.encode(toMap());
}
