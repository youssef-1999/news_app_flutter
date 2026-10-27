import 'package:news_app/common/error/error_model.dart';
import 'package:news_app/news/modal/model/article_response_model/article.dart';
import 'package:news_app/news/modal/model/data_source/main_layer_data_source.dart';
import 'package:news_app/news/modal/model/source_model.dart';

class CashDataSource extends MainLayerDataSource {
  @override
  Future<(ErrorModel?, List<Article>?)> getArticles(String sourceId) async{
    // TODO: implement getArticles
    return (GeneralError(), null);
  }

  @override
  Future<(ErrorModel?, List<Sources>?)> getSources(String category)async {
    // TODO: implement getSources
        return (GeneralError(), null);

  }
}