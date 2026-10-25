import 'package:flutter/material.dart';
import 'package:news_app/common/error/error_model.dart';
import 'package:news_app/enums/news_category.dart';
import 'package:news_app/news/modal/model/article_response_model/article.dart';
import 'package:news_app/news/modal/model/source_model.dart';
import 'package:news_app/news/modal/network/network_services.dart';

// The bridge between View and Model: views only talk to this class,
// and only this class talks to NetworkServices
class MainLayerProvider extends ChangeNotifier {
  NewsCategory? selectedCategory;
  List <Sources>? sources;
  bool isSourcesLoading = false;
  String? selectedSourceId;
  List<Article>? articles;
  bool isArticlesLoading = false;
  String? articlesError;
  String? sourcesError;

  // Warm up the sources requests for every category when Home opens
  void prefetchSources() {
    for (final category in NewsCategory.values) {
      NetworkServices.getSources(category.name);
    }
  }

  void setSelectedCategory(NewsCategory category) {
    selectedCategory = category;
    notifyListeners();
  }

  void clearSelectedCategory() {
    selectedCategory = null;
    notifyListeners();
  }

  Future<void> getSources() async {
    isSourcesLoading = true;
    sourcesError = null;
    notifyListeners();
    if (selectedCategory != null) {
      final (ErrorModel? error, List<Sources>? data) =
          await NetworkServices.getSources(selectedCategory!.name);
      if (error != null) {
        sources = null;
        sourcesError = error.message;
        debugPrint('getSources error: $sourcesError');
      } else {
        sources = data;
      }
    }
    isSourcesLoading = false;
     notifyListeners();

    // Load articles for the first tab
    final firstSourceId = sources?.firstOrNull?.id;
    if (firstSourceId != null) {
      getArticles(firstSourceId);
    }
  }

  // Called by the view on tab taps and swipes
  void onSourceSelected(int index) {
    final sourceId = sources?.elementAtOrNull(index)?.id;
    if (sourceId != null && sourceId != selectedSourceId) {
      getArticles(sourceId);
    }
  }

  Future<void> getArticles(String sourceId) async {
    selectedSourceId = sourceId;
    isArticlesLoading = true;
    articles = null;
    articlesError = null;
    notifyListeners();
    final (ErrorModel? error, List<Article>? data) =
        await NetworkServices.getArticles(sourceId);
    // Ignore the result if the user switched to another tab meanwhile
    if (selectedSourceId != sourceId) return;
    if (error != null) {
      articlesError = error.message;
      debugPrint('getArticles error: $articlesError');
    } else {
      articles = data;
    }
    isArticlesLoading = false;
    notifyListeners();
  }
}
