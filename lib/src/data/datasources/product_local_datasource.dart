import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/api_constants.dart';
import '../../../core/error/exceptions.dart';

abstract class ProductLocalDataSource {
  Future<Set<int>> getFavoriteIds();
  Future<void> saveFavoriteIds(Set<int> ids);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences prefs;
  ProductLocalDataSourceImpl(this.prefs);

  @override
  Future<Set<int>> getFavoriteIds() async {
    try {
      final list = prefs.getStringList(ApiConstants.favoritesKey) ?? [];
      return list.map(int.parse).toSet();
    } catch (_) {
      throw const CacheException();
    }
  }

  @override
  Future<void> saveFavoriteIds(Set<int> ids) async {
    final ok = await prefs.setStringList(
      ApiConstants.favoritesKey,
      ids.map((e) => e.toString()).toList(),
    );
    if (!ok) throw const CacheException();
  }
}
