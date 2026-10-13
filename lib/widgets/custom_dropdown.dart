import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/themes/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.onSelected,
    this.initialSelection,
    this.width,
  });

  /// Map of value -> label shown in the menu.
  final Map<T, String> items;
  final ValueChanged<T> onSelected;
  final T? initialSelection;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: initialSelection,
      width: width ?? 237.w,
      textStyle: AppTextStyles.styleW500s20(color: AppColors.lightTextColor),

      // 1. Decorating the Outer Text Box Container
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkBgColor,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.lightTextColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.lightTextColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.lightTextColor, width: 2),
        ),
      ),

      // 2. Decorating the Opened Menu Popup List
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.darkBgColor),
        elevation: WidgetStateProperty.all(8),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(color: AppColors.lightTextColor, width: 1),
          ),
        ),
      ),

      dropdownMenuEntries: items.entries
          .map(
            (entry) => DropdownMenuEntry<T>(
              value: entry.key,
              label: entry.value,
              style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(AppColors.lightTextColor),
              ),
            ),
          )
          .toList(),
      onSelected: (value) {
        if (value != null) onSelected(value);
      },
    );
  }
}
