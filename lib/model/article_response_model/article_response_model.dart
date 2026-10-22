import 'dart:convert';

import 'article.dart';

class ArticleResponseModel {
	String? status;
	int? totalResults;
	List<Article>? articles;

	ArticleResponseModel({this.status, this.totalResults, this.articles});

	@override
	String toString() {
		return 'ArticleResponseModel(status: $status, totalResults: $totalResults, articles: $articles)';
	}

	factory ArticleResponseModel.fromMap(Map<String, dynamic> data) {
		return ArticleResponseModel(
			status: data['status'] as String?,
			totalResults: data['totalResults'] as int?,
			articles: (data['articles'] as List<dynamic>?)
						?.map((e) => Article.fromMap(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toMap() => {
				'status': status,
				'totalResults': totalResults,
				'articles': articles?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ArticleResponseModel].
	factory ArticleResponseModel.fromJson(String data) {
		return ArticleResponseModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ArticleResponseModel] to a JSON string.
	String toJson() => json.encode(toMap());
}
