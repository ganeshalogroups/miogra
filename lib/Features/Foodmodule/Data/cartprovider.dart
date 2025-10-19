import 'dart:async';
import 'package:testing/Features/Foodmodule/Domain/favouritemodel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesProvider with ChangeNotifier {
  List<FavoriteRestaurant> _favorites = [];

  FavoritesProvider() {
    initializeDatabase();
  }

  late Database _db;

  List<FavoriteRestaurant> get favorites => _favorites;

  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');

    _db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, city TEXT, region TEXT, imageUrl TEXT, rating REAL)',
        );
      },
      version: 1,
    );
    await _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final data = await _db.query('favorites');

    _favorites = data.map((item) => FavoriteRestaurant.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addFavorite(FavoriteRestaurant restaurant) async {
    await _db.insert('favorites', restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _favorites.add(restaurant);

    notifyListeners();
  }

  Future<void> removeFavorite(String id) async {
    await _db.delete('favorites', where: 'id = ?', whereArgs: [id]);
    _favorites.removeWhere((restaurant) => restaurant.id == id);
    notifyListeners();
  }

// remove all favourite list

Future<void> removeAllFavorites() async {
  await _db.delete('favorites'); // Deletes all rows from the 'favorites' table
  _favorites.clear(); // Clears the in-memory list
  notifyListeners(); // Notifies UI of the changes
}


  bool isFavorite(String id) {
    return _favorites.any((restaurant) => restaurant.id == id);
  }

// Function to delete the database and clear all data
  Future<void> deleteDatabaseAndData() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');

    // Delete the database
    await deleteDatabase(path);

    // Clear in-memory favorites
    _favorites.clear();
    notifyListeners();
  }
}

class ListProvider with ChangeNotifier {
  List<String> locfavorite = [];

  bool isFavorite(String restaurantId) {
    return locfavorite.contains(restaurantId);
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
