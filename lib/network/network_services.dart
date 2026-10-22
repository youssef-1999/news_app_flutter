import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/model/article_response_model/article.dart';
import 'package:news_app/model/article_response_model/article_response_model.dart';
import 'package:news_app/model/source_model.dart';
import 'package:news_app/network/consts.dart';
import 'package:news_app/network/endpoint.dart';

class NetworkServices {
  static final Dio _dio = Dio(BaseOptions(baseUrl: Consts.baseUrl));

  static Future<List<Sources>?> getSources(String category) async {
    final response = await _dio.get(Endpoint.sources, queryParameters: {
      'apiKey': Consts.APIKEY,
      'category': category,
    });
    debugPrint("---> $response.data.toString()  $category");

    if (response.data?['status'] == 'ok') {
      return sourceModel.fromJson(response.data).sources;
    }
    log('Error: ${response.statusCode}');
    return null;
  }

  static Future<List<Article>?> getArticles(String sourceId) async {
    final response = await _dio.get(Endpoint.articles, queryParameters: {
      'sources': sourceId,
      'apiKey': Consts.APIKEY,
    });
    debugPrint("---> ${response.data}  $sourceId");

    if (response.data?['status'] == 'ok') {
      return ArticleResponseModel.fromMap(response.data).articles;
    }
    log('Error: ${response.statusCode}');
    return null;
  }
}
