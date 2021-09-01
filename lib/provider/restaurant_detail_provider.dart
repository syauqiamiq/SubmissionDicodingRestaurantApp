import 'package:flutter/foundation.dart';
import 'package:restaurant_app/models/restaurant_detail_model.dart';
import 'package:restaurant_app/services/api_services.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetail();
  }

  late RestaurantDetail _restaurantDetail;
  late String _message = '';
  late ResultState _state;

  String get message => _message;

  RestaurantDetail get resultDetail => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurantDetail(id);
      if (restaurants.restaurant.id.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
