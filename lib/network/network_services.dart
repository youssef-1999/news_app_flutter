import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app/model/source_model.dart';
import 'package:news_app/network/consts.dart';
import 'package:news_app/network/endpoint.dart';

class NetworkServices {
static Future<List<Sources>?> getSources(String category) async{
   Dio dio=Dio(BaseOptions(
    baseUrl: Consts.baseUrl,queryParameters: {
      'apiKey': Consts.APIKEY,
      'category': category,
    }));
  Response response = await  dio.get(Endpoint.sources,queryParameters: {
      'apiKey': Consts.APIKEY,
      'category': category,
    });

    if(response.statusCode==200 && response.data!=null && response.data['status'].toLowerCase()=='ok'){
      sourceModel sourcesModel = sourceModel.fromJson(response.data);
      return sourcesModel.sources;


    }
    else log('Error: ${response.statusCode}');
}
}