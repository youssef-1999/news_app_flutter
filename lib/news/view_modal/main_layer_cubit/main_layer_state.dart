import 'package:news_app/enums/news_category.dart';
import 'package:news_app/news/modal/model/article_response_model/article.dart';
import 'package:news_app/news/modal/model/source_model.dart';

abstract class MainLayerState {
  final NewsCategory? selectedCategory;

  MainLayerState({this.selectedCategory});
}

class MainLayerInitialState extends MainLayerState {
  MainLayerInitialState() : super(selectedCategory: null);
}

class SelectedCategoryState extends MainLayerState {
  SelectedCategoryState({required super.selectedCategory});
}

//sources
class GetSourcesLoading extends MainLayerState {
  GetSourcesLoading({required super.selectedCategory});
}

class GetSourcesSuccess extends MainLayerState {
  final List<Sources> sources;
  GetSourcesSuccess({required super.selectedCategory, required this.sources});
}

class GetSourcesError extends MainLayerState {
  final String? message;
  GetSourcesError({required super.selectedCategory, this.message});
}

//articles
class GetArticlesLoading extends MainLayerState {
  final String sourceId;
  GetArticlesLoading({required super.selectedCategory, required this.sourceId});
}

class GetArticlesSuccess extends MainLayerState {
  final String sourceId;
  final List<Article> articles;
  GetArticlesSuccess({
    required super.selectedCategory,
    required this.sourceId,
    required this.articles,
  });
}

class GetArticlesError extends MainLayerState {
  final String sourceId;
  final String? message;
  GetArticlesError({
    required super.selectedCategory,
    required this.sourceId,
    this.message,
  });
}
