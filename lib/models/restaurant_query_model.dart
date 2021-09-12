import 'package:restaurant_app/models/restaurant_api_model.dart';

class RestaurantQuery {
  RestaurantQuery({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory RestaurantQuery.fromJson(Map<String, dynamic> json) =>
      RestaurantQuery(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
