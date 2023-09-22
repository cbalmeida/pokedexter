import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider._() {
    _loadCache();
  }

  static FavoritesProvider? _instance;
  static FavoritesProvider get instance => _instance ??= FavoritesProvider._();

  SharedPreferences? _prefs;
  Future<SharedPreferences> _getSharedPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Map<String, dynamic> _cache = {};

  _loadCache() async {
    SharedPreferences prefs = await _getSharedPrefs();
    String favorites = prefs.getString("favorites") ?? '{}';
    _cache = jsonDecode(favorites);
    notifyListeners();
  }

  Future<void> _saveCache() async {
    SharedPreferences prefs = await _getSharedPrefs();
    await prefs.setString("favorites", jsonEncode(_cache));
  }

  List<int> get favorites => _cache.keys.map((e) => int.parse(e)).toList();

  void toggleFavorite(int pokemonId) async {
    if (isFavorite(pokemonId)) {
      _cache.remove(pokemonId.toString());
    } else {
      _cache[pokemonId.toString()] = true;
    }
    notifyListeners();
    await _saveCache();
  }

  bool isFavorite(int pokemonId) {
    return _cache.containsKey(pokemonId.toString());
  }
}
