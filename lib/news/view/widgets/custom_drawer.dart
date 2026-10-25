import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/common/extensions/widget_extension.dart';
import 'package:news_app/themes/app_colors.dart';
import 'package:news_app/themes/app_theme.dart';
import 'package:news_app/news/view/widgets/custom_dropdown.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.darkTextColor,
      width: .7.sw,
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: .stretch,
        
        children: [
          Container(
            alignment: Alignment.center,
            height: 166.h,
            color: AppColors.lightTextColor,
            child:  Text("News App",style:AppTextStyles.styleW700s24(color: AppColors.darkTextColor),),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.lightTextColor),
            title: Text('Go To Home', style: AppTextStyles.styleW700s20(color: AppColors.lightTextColor)),
            onTap: () {
              Navigator.pushNamed(context, '/home-screen');
            },
          ),
          Divider(indent: 16.w, endIndent: 16.w),
          ListTile(
            leading: const Icon(Icons.imagesearch_roller_sharp, color: AppColors.lightTextColor),
            title: Text('Themes', style: AppTextStyles.styleW700s20(color: AppColors.lightTextColor)),
           
          ),
          CustomDropdown<ThemeMode>(
            initialSelection: AppTheme.themeMode.value,
            items: const {
              ThemeMode.light: 'Light',
              ThemeMode.dark: 'Dark',
            },
            onSelected: (mode) => AppTheme.themeMode.value = mode,
          ).withLeftRightBottomTopPadding(left: 16.w, right: 16.w, bottom: 20.h),




          Divider(indent: 16.w, endIndent: 16.w),
          ListTile(
            leading: const Icon(Icons.language, color: AppColors.lightTextColor),
            title: Text('Language', style: AppTextStyles.styleW700s20(color: AppColors.lightTextColor)),
            
          ),
          Padding(
            padding:  EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
            child: CustomDropdown<String>(
              initialSelection: 'English',
              items: const {
                'English': 'English',
                'Arabic': 'Arabic',
              },
              onSelected: (language) {
                // Handle language selection
              },
            ),
          ),
        ],
      ),
    );
  }
}
