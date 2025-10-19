
// ignore_for_file: file_names, non_constant_identifier_names

import 'package:testing/Meat/MeatDomain/Meatfavmodel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MeatFavoritesProvider with ChangeNotifier {
  List<MeatFavoriteShop> _favorites = [];

  FavoritesProviderformeat() {
    initializeDatabase();
  }

  late Database _db;

  List<MeatFavoriteShop> get favorites => _favorites;

  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'meatfavorites.db');

    _db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE meatfavorites(id TEXT PRIMARY KEY, name TEXT, city TEXT, region TEXT, imageUrl TEXT, rating REAL)',
        );
      },
      version: 1,
    );
    await _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final data = await _db.query('meatfavorites');

    _favorites = data.map((item) => MeatFavoriteShop.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addFavorite(MeatFavoriteShop restaurant) async {
    await _db.insert('meatfavorites', restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _favorites.add(restaurant);

    notifyListeners();
  }

  Future<void> removeFavorite(String id) async {
    await _db.delete('meatfavorites', where: 'id = ?', whereArgs: [id]);
    _favorites.removeWhere((restaurant) => restaurant.id == id);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.any((restaurant) => restaurant.id == id);
  }

// Function to delete the database and clear all data
  Future<void> deleteDatabaseAndData() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'meatfavorites.db');

    // Delete the database
    await deleteDatabase(path);

    // Clear in-memory favorites
    _favorites.clear();
    notifyListeners();
  }
}

class MeatListProvider with ChangeNotifier {
  List<String> locfavorite = [];

  bool isFavorite(String shopId) {
    return locfavorite.contains(shopId);
  }

  void addListdata({required String localIdList}) {
    if (!locfavorite.contains(localIdList)) {
      locfavorite.add(localIdList);
      notifyListeners(); // Notify the UI about the change

    } else {
    }

  }

  void removeListdata({required String localIdList}) {
    if (locfavorite.contains(localIdList)) {
      locfavorite.remove(localIdList);
      notifyListeners(); // Notify the UI about the change
    } else {
    }

  }
}
