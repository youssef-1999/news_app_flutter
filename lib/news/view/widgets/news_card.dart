import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/app_text_styles.dart';
import 'package:news_app/news/modal/model/article_response_model/article.dart';
import 'package:news_app/common/network/image_cache_manager.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage;
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
          if (imageUrl != null && imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                cacheManager: ImageCacheManager.instance,
                httpHeaders: ImageCacheManager.headers,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const SizedBox(
                  height: 200,
                  child: Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey)),
                ),
              ),
            ),
          const SizedBox(height: 10),
          Text(
            article.title ?? article.description ?? '',
            style: AppTextStyles.styleW700s16(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'By: ${article.author ?? 'Unknown'}',
                  style: AppTextStyles.styleW500s18(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                article.publishedAt?.split('T').first ?? '',
                style: AppTextStyles.styleW500s12(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
