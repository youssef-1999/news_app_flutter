import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/error/error_model.dart';
import 'package:news_app/news/modal/model/article_response_model/article.dart';
import 'package:news_app/news/modal/model/source_model.dart';
import 'package:news_app/news/repository/main_layer_repository.dart';
import 'package:news_app/news/view_modal/main_layer_cubit/main_layer_state.dart';
import 'package:news_app/enums/news_category.dart';

class MainLayerCubit extends Cubit<MainLayerState> {
  final MainLayerRepository _mainLayerRepository;
  MainLayerCubit({required this._mainLayerRepository})
      : super(MainLayerInitialState());

  // Kept here because article states replace GetSourcesSuccess right away,
  // often before the UI ever rebuilds with it
  List<Sources> sources = [];

  void selectCategory(NewsCategory category) {
    sources = [];
    emit(SelectedCategoryState(selectedCategory: category));
    getSources(category);
  }

  // Back to Home: no category selected
  void clearCategory() {
    sources = [];
    emit(MainLayerInitialState());
  }

  Future<void> getSources(NewsCategory category) async {
    emit(GetSourcesLoading(selectedCategory: category));
    final (ErrorModel? error, List<Sources>? data) =
        await _mainLayerRepository.getSources(category.name);
    if (error != null) {
      emit(GetSourcesError(selectedCategory: category, message: error.message));
      return;
    }
    sources = data ?? [];
    emit(GetSourcesSuccess(selectedCategory: category, sources: sources));

    // Load articles for the first tab
    final firstSourceId = sources.firstOrNull?.id;
    if (firstSourceId != null) {
      getArticles(firstSourceId);
    }
  }

  Future<void> getArticles(String sourceId) async {
    final category = state.selectedCategory;
    emit(GetArticlesLoading(selectedCategory: category, sourceId: sourceId));
    final (ErrorModel? error, List<Article>? data) =
        await _mainLayerRepository.getArticles(sourceId);
    if (error != null) {
      emit(GetArticlesError(
          selectedCategory: category, sourceId: sourceId, message: error.message));
    } else {
      emit(GetArticlesSuccess(
          selectedCategory: category, sourceId: sourceId, articles: data ?? []));
    }
  }
}
