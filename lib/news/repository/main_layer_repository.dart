import 'package:news_app/common/error/error_model.dart';
import 'package:news_app/news/modal/model/article_response_model/article.dart';
import 'package:news_app/news/modal/model/data_source/main_layer_data_source.dart';
import 'package:news_app/news/modal/model/source_model.dart';

class MainLayerRepository {
  final MainLayerDataSource _network_sevices;

  MainLayerRepository({required MainLayerDataSource dataSource})
      : _network_sevices = dataSource;

  Future<(ErrorModel? error, List<Sources>? data)> getSources(
      String categoryId) async {
    return await _network_sevices.getSources(categoryId);
  }

  Future<(ErrorModel? error, List<Article>? data)> getArticles(
      String sourceId) async {
    return await _network_sevices.getArticles(sourceId);
  }
}
