import 'package:flutter/material.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/enums/news_category.dart';
import 'package:news_app/provider/main_layer_provider.dart';
import 'package:news_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  static const routeName = '/general_screen';
  final NewsCategory category;
  const GeneralScreen({super.key, required this.category});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch sources for the selected category
WidgetsBinding.instance.addPostFrameCallback((_) {
  Provider.of<MainLayerProvider>(context, listen: false).getSources();
});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayerProvider>(context);
    final sources = provider.sources ?? [];

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
      child: DefaultTabController(
        // Recreate the controller when the number of sources changes
        key: ValueKey(sources.length),
        length: sources.length,
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
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: sources
                  .map((source) => Tab(text: source.name ?? ''))
                  .toList(),
            ),
          ),
          body: provider.isSourcesLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: sources
                      .map((source) => Center(child: Text(source.name ?? '')))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
