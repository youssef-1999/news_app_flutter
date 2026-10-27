import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/enums/news_category.dart';
import 'package:news_app/news/modal/model/source_model.dart';
import 'package:news_app/news/view_modal/main_layer_cubit/main_layer_cubit.dart';
import 'package:news_app/news/view_modal/main_layer_cubit/main_layer_state.dart';
import 'package:news_app/news/view/widgets/custom_drawer.dart';
import 'package:news_app/news/view/widgets/news_card.dart';

class GeneralScreen extends StatefulWidget {
  static const routeName = '/general_screen';
  final NewsCategory category;
  const GeneralScreen({super.key, required this.category});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<Sources> get _sources => context.read<MainLayerCubit>().sources;

  // Recreate the controller when the number of sources changes
  void _syncTabController(List<Sources> sources) {
    if (_tabController?.length == sources.length) return;
    final old = _tabController;
    _tabController = TabController(length: sources.length, vsync: this)
      ..addListener(_onTabChanged);
    // Dispose after this frame so the old TabBar can detach from it first
    if (old != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    }
  }

  // Fires on both tab taps and swipes
  void _onTabChanged() {
    // A tap fires this twice (during and after the animation); only react once
    if (_tabController!.indexIsChanging) return;
    final sourceId = _sources[_tabController!.index].id;
    if (sourceId != null) {
      context.read<MainLayerCubit>().getArticles(sourceId);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayerCubit, MainLayerState>(
      builder: (context, state) {
        _syncTabController(_sources);

        // Back button returns to Home by clearing the selected category
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              context.read<MainLayerCubit>().clearCategory();
            }
          },
          child: Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.category.title,
                  style: AppTextStyles.styleW500s20()),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Open search
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: _sources
                    .map((source) => Tab(text: source.name ?? ''))
                    .toList(),
              ),
            ),
            body: state is GetSourcesLoading || state is SelectedCategoryState
                ? const Center(child: CircularProgressIndicator())
                : state is GetSourcesError
                    ? Center(
                        child: Text(state.message ?? 'Something went wrong'))
                    : TabBarView(
                        controller: _tabController,
                        children: _sources
                            .map((source) => _ArticlesList(sourceId: source.id))
                            .toList(),
                      ),
          ),
        );
      },
    );
  }
}

class _ArticlesList extends StatelessWidget {
  final String? sourceId;
  const _ArticlesList({required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayerCubit, MainLayerState>(
      builder: (context, state) {
        if (state is GetArticlesError && state.sourceId == sourceId) {
          return Center(child: Text(state.message ?? 'Something went wrong'));
        }
        // The cubit only holds the articles of the currently selected tab
        if (state is! GetArticlesSuccess || state.sourceId != sourceId) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.articles.isEmpty) {
          return const Center(child: Text('No articles found'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.articles.length,
          itemBuilder: (context, index) =>
              NewsCard(article: state.articles[index]),
        );
      },
    );
  }
}
