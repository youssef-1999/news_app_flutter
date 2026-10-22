import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/enums/news_category.dart';
import 'package:news_app/model/article_response_model/article.dart';
import 'package:news_app/model/source_model.dart';
import 'package:news_app/network/network_services.dart';

class MainLayerProvider extends ChangeNotifier {
  NewsCategory? selectedCategory;
  List <Sources>? sources;
  bool isSourcesLoading = false;
  String? selectedSourceId;
  List<Article>? articles;
  bool isArticlesLoading = false;
  String? articlesError;
  String? sourcesError;

  // NewsAPI puts the real reason (e.g. rateLimited, apiKeyInvalid) in the body
  String _errorMessage(Object e) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) return data['message'];
      // For DioExceptionType.unknown the real cause (SocketException,
      // HandshakeException, ...) is only in e.error
      return e.message ?? e.error?.toString() ?? e.type.name;
    }
    return e.toString();
  }

  void setSelectedCategory(NewsCategory category) {
    selectedCategory = category;
    notifyListeners();
  }

  void clearSelectedCategory() {
    selectedCategory = null;
    notifyListeners();
  }
  getSources()async {
    isSourcesLoading = true;
    sourcesError = null;
    notifyListeners();
    try {
      if(selectedCategory!=null){
       List<Sources>? response =await   NetworkServices.getSources(selectedCategory!.name);
       sources = response;
      }
    } catch (e) {
      sourcesError = _errorMessage(e);
      debugPrint('getSources error: $sourcesError');
    }
     isSourcesLoading = false;
     notifyListeners();

    // Load articles for the first tab
    final firstSourceId = sources?.firstOrNull?.id;
    if (firstSourceId != null) {
      getArticles(firstSourceId);
    }
  }

  getArticles(String sourceId) async {
    selectedSourceId = sourceId;
    isArticlesLoading = true;
    articles = null;
    articlesError = null;
    notifyListeners();
    try {
      List<Article>? response = await NetworkServices.getArticles(sourceId);
      // Ignore the result if the user switched to another tab meanwhile
      if (selectedSourceId != sourceId) return;
      articles = response;
    } catch (e) {
      debugPrint('getArticles error: ${_errorMessage(e)}');
      if (selectedSourceId != sourceId) return;
      articlesError = _errorMessage(e);
    }
    isArticlesLoading = false;
    notifyListeners();
  }
}