import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/financial_product_model.dart';

const _kCacheKey = 'dashboard_products_cache';
const _kCacheTimestampKey = 'dashboard_cache_timestamp';

class DashboardLocalDataSource {
  Future<List<FinancialProductModel>?> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_kCacheKey);

    if (jsonString == null) return null;

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((e) => FinancialProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> cacheProducts(List<FinancialProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(products.map((e) => e.toJson()).toList());
    await prefs.setString(_kCacheKey, jsonString);
    await prefs.setString(
      _kCacheTimestampKey,
      DateTime.now().toIso8601String(),
    );
  }

  Future<DateTime?> getCacheTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString(_kCacheTimestampKey);
    if (timestamp == null) return null;
    return DateTime.parse(timestamp);
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kCacheKey);
    await prefs.remove(_kCacheTimestampKey);
  }
}
