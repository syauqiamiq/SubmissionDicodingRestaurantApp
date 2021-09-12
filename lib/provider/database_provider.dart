import 'package:flutter/foundation.dart';
import 'package:restaurant_app/models/restaurant_api_model.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/services/db/database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favoriteRestaurant = [];
  List<Restaurant> get favoriteRestaurant => _favoriteRestaurant;

  void _getFavorite() async {
    _favoriteRestaurant = await databaseHelper.getFavorite();
    if (_favoriteRestaurant.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant resto) async {
    try {
      await databaseHelper.insertFavorite(resto);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final bookmarkedArticle = await databaseHelper.getFavoriteById(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
