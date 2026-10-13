import 'package:flutter/material.dart';
import 'package:news_app/enums/news_category.dart';
import 'package:news_app/model/source_model.dart';
import 'package:news_app/network/network_services.dart';

class MainLayerProvider extends ChangeNotifier {
  NewsCategory? selectedCategory;
  List <Sources>? sources;
  bool isSourcesLoading = false;

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
    notifyListeners();
    if(selectedCategory!=null){
     List<Sources>? response =await   NetworkServices.getSources(selectedCategory!.name);
     sources = response;
     notifyListeners();
    }
     isSourcesLoading = false;
     notifyListeners();

  }
}