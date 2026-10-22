import 'package:flutter/material.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/enums/news_category.dart';
import 'package:news_app/model/source_model.dart';
import 'package:news_app/provider/main_layer_provider.dart';
import 'package:news_app/widgets/custom_drawer.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

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
  List<Sources> _sources = [];

  @override
  void initState() {
    super.initState();
    // Fetch sources for the selected category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MainLayerProvider>(context, listen: false).getSources();
    });
  }

  // Recreate the controller when the number of sources changes
  void _syncTabController(List<Sources> sources) {
    _sources = sources;
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
    final index = _tabController!.index;
    if (index >= _sources.length) return;
    final sourceId = _sources[index].id;
    final provider = Provider.of<MainLayerProvider>(context, listen: false);
    if (sourceId != null && sourceId != provider.selectedSourceId) {
      provider.getArticles(sourceId);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayerProvider>(context);
    final sources = provider.sources ?? [];
    _syncTabController(sources);

    // Back button returns to Home by clearing the selected category
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Provider.of<MainLayerProvider>(
            context,
            listen: false,
          ).clearSelectedCategory();
        }
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.category.title, style: AppTextStyles.styleW500s20()),
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
            tabs: sources
                .map((source) => Tab(text: source.name ?? ''))
                .toList(),
          ),
        ),
        body: provider.isSourcesLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.sourcesError != null
                ? Center(child: Text(provider.sourcesError!))
                : TabBarView(
                    controller: _tabController,
                    children: sources
                        .map((source) => _ArticlesList(sourceId: source.id))
                        .toList(),
                  ),
      ),
    );
  }
}

class _ArticlesList extends StatelessWidget {
  final String? sourceId;
  const _ArticlesList({required this.sourceId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayerProvider>(context);
    // The provider only holds the articles of the currently selected tab
    if (provider.selectedSourceId != sourceId || provider.isArticlesLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.articlesError != null) {
      return Center(child: Text(provider.articlesError!));
    }
    final articles = provider.articles ?? [];
    if (articles.isEmpty) {
      return const Center(child: Text('No articles found'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (context, index) => NewsCard(article: articles[index]),
    );
  }
}
