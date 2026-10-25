import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/common/extensions/widget_extension.dart';
import 'package:news_app/enums/news_category.dart';
import 'package:news_app/gen/assets.gen.dart';
import 'package:news_app/news/view_modal/provider/main_layer_provider.dart';
import 'package:news_app/news/view/screens/general_screen.dart';
import 'package:news_app/themes/app_colors.dart';
import 'package:news_app/news/view/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  static final List<AssetGenImage> _lightImages = [
    Assets.images.home.general,
    Assets.images.home.busniess,
    Assets.images.home.sport,
    Assets.images.home.technology,
    Assets.images.home.science,
    Assets.images.home.helth,
    Assets.images.home.entertainment,
  ];

  static final List<AssetGenImage> _darkImages = [
    Assets.images.home.general1,
    Assets.images.home.busniess1,
    Assets.images.home.sport1,
    Assets.images.home.technology1,
    Assets.images.home.science1,
    Assets.images.home.helth1,
    Assets.images.home.entertainment1,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Cards use the opposite theme so they stand out from the scaffold
    final images = isDark ? _lightImages : _darkImages;
    final cardBgColor = isDark ? AppColors.lightBgColor : AppColors.darkBgColor;
    final cardTextColor =
        isDark ? AppColors.darkTextColor : AppColors.lightTextColor;

    return ChangeNotifierProvider(
      create:(BuildContext context) => MainLayerProvider()..prefetchSources(),
      child: Consumer<MainLayerProvider>(
        builder: (context, provider, _) {
          final selectedCategory = provider.selectedCategory;
          if (selectedCategory != null) {
            return GeneralScreen(category: selectedCategory);
          }
          return Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: Text('Home', style: AppTextStyles.styleW500s20()),
              leading: Builder(
                // Builder gives a context below the Scaffold so Scaffold.of works
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
            ),
            body:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                    Text(
                      'Good Morning',
                      style:context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                  
                  Text(
                      'Here is Some News For You',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => (SizedBox(height: 16)),
                      itemBuilder: (context, index) {
                        final isEven = index.isEven;
                        return Container(
                          height: 198,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              images[index].image(fit: BoxFit.cover),
                              Align(
                                // Even index -> text on the right, odd -> on the left
                                alignment: isEven
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: isEven
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      NewsCategory.values[index].title,
                                      style: AppTextStyles.styleW600s24().copyWith(
                                        color: cardTextColor,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Material(
                                      color: AppColors.greyBgColor,
                                      shape: const StadiumBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: InkWell(
                                        onTap: () {
                                          Provider.of<MainLayerProvider>(
                                            context,
                                            listen: false,
                                          ).setSelectedCategory(
                                            NewsCategory.values[index],
                                          );
                                        },
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            // Arrow sits on the side it points to
                                            textDirection: isEven
                                                ? TextDirection.rtl
                                                : TextDirection.ltr,
                                            children: [
                                              Text(
                                                'View All',
                                                style: AppTextStyles.styleW600s16()
                                                    .copyWith(
                                                  color:isDark?AppColors.lightTextColor: AppColors.darkTextColor,
                                                ),
                                              ).withPadding(horizontal: 12.w),
                                              Container(
                                                // Padding inside the circle so the bg surrounds the icon
                                                padding: EdgeInsets.all(8.w),
                                                decoration: BoxDecoration(
                                                  color:isDark?AppColors.darkBgColor:AppColors.lightBgColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  isEven
                                                      ? Icons.arrow_back_ios_new
                                                      : Icons.arrow_forward_ios,
                                                  size: 16,
                                                  color: isDark?AppColors.lightTextColor: AppColors.darkTextColor,
                                                ),
                                              ).withAllPadding(all: 4.w),
                                            ],
                                          ),
                                      ),
                                    ),
                                  ],
                                ).withAllPadding(all: 30.w),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: images.length,
                    ),
                  ),
                  
                ],
              ),
            ),
           
          );
        }
      ),
    );
  }
}