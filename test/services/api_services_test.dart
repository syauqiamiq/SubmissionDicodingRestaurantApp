import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/restaurant_api_model.dart';
import 'package:restaurant_app/services/api_services.dart';

void main() {
  test(
    "Memanggil Salah Satu Nama Restaurant dari API Restaurant",
    () async {
      //arrange
      var resto = await ApiServices().getRestaurant();

      //act
      var callingApi = resto;

      //assert
      RestaurantList result = callingApi;
      expect(result.restaurants[0].name, "Melting Pot");
    },
  );
}
