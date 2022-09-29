import 'package:flutter_advanced/data/response/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY"; // key

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<HomeResponse> getHomeData() {
    // TODO: implement getHomeData
    throw UnimplementedError();
  }

  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }
}

class CachedItem {
  dynamic data; // value
  int cacheTime = DateTime.now().millisecondsSinceEpoch; // already saved during creation
  CachedItem(this.data);
}
