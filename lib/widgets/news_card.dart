import 'package:flutter/material.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/model/news_model.dart';

class NewsCard extends StatelessWidget {
final NewsModel newsModel;
  const NewsCard({super.key, required this.newsModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(newsModel.imageUrl),
          const SizedBox(height: 10),
          Text(
            newsModel.description,
            style: AppTextStyles.styleW700s16(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'By:${newsModel.author}',
                style: AppTextStyles.styleW500s18(),
              ),
              Text(
                newsModel.publishedAt,
                style: AppTextStyles.styleW500s12(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
