import 'package:flutter/foundation.dart';
import 'package:restaurant_app/models/restaurant_query_model.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/services/api_services.dart';

class RestaurantQueryProvider extends ChangeNotifier {
  final ApiServices apiService;

  RestaurantQueryProvider({required this.apiService}) {
    _fetchRestaurantQuery();
  }

  late RestaurantQuery _restaurantQuery;
  late String _message = '';
  late ResultState _state;
  late String context = '';

  String get message => _message;

  RestaurantQuery get resultQuery => _restaurantQuery;

  ResultState get state => _state;

  void setContext(String value) {
    this.context = value;
    _fetchRestaurantQuery();
  }

  Future<dynamic> _fetchRestaurantQuery() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurantQuery(context);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantQuery = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
