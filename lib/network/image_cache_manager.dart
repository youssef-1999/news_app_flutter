import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

// Fails slow image requests instead of letting them hang forever
class _TimeoutClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final Duration timeout;

  _TimeoutClient(this.timeout);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _inner.send(request).timeout(timeout);
}

class ImageCacheManager {
  static const key = 'newsImageCache';

  static final CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
      fileService: HttpFileService(
        httpClient: _TimeoutClient(const Duration(seconds: 15)),
      ),
    ),
  );

  // Some news sites reject requests that don't look like a browser
  static const headers = {
    'User-Agent':
        'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Mobile Safari/537.36',
  };
}
