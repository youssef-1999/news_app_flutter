import 'package:news_app/common/error/error_model.dart';
import 'package:news_app/news/modal/model/article_response_model/article.dart';
import 'package:news_app/news/modal/model/source_model.dart';
import 'package:news_app/news/modal/network/network_services.dart';

abstract class MainLayerDataSource {
  Future<(ErrorModel? error, List<Sources>? data)> getSources(String category);
  Future<(ErrorModel? error, List<Article>? data)> getArticles(String sourceId);
}

class MainLayerRemoteDataSource implements MainLayerDataSource {
  @override
  Future<(ErrorModel? error, List<Sources>? data)> getSources(String category) =>
      NetworkServices.getSources(category);

  @override
  Future<(ErrorModel? error, List<Article>? data)> getArticles(String sourceId) =>
      NetworkServices.getArticles(sourceId);
}
