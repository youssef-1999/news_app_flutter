import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/news/service_locator/di.dart';
import 'package:news_app/news/view/screens/home_screen.dart';
import 'package:news_app/themes/app_theme.dart';

void main() {
  configureDependencies();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: AppTheme.themeMode,
        builder: (context, mode, _) => MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (_) => const HomeScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
