import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/common/error/error_model.dart';
import 'package:news_app/model/article_response_model/article.dart';
import 'package:news_app/model/article_response_model/article_response_model.dart';
import 'package:news_app/model/source_model.dart';
import 'package:news_app/network/consts.dart';
import 'package:news_app/network/endpoint.dart';

class NetworkServices {
  static final Dio _dio = Dio(BaseOptions(baseUrl: Consts.baseUrl));

  static Future<(ErrorModel?, List<Sources>?)> getSources(String category) async {
    try {
      final response = await _dio.get(Endpoint.sources, queryParameters: {
        'apiKey': Consts.APIKEY,
        'category': category,
      });
      debugPrint("---> ${response.data}  $category");

      if (response.data?['status'] == 'ok') {
        return (null, sourceModel.fromJson(response.data).sources);
      }
      final data = response.data;
      return (
        GeneralError(
          errorMessage: data is Map ? data['message'] as String? : null,
          errorCode: data is Map ? data['code'] as String? : null,
        ),
        null,
      );
    } on DioException catch (e) {
      final ErrorModel error = ErrorModel.fromDioException(e);
      log('Error: ${error.message} (${error.errorCode})');
      return (error, null);
    } catch (e) {
      log('Error: $e');
      return (TypeParseError(errorMessage: e.toString()), null);
    }
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
