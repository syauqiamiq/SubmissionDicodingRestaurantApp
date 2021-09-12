import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/result_state.dart';
import 'package:restaurant_app/view/restaurant_detail.dart';

class FavoriteRestaurantScreen extends StatelessWidget {
  static const routeName = '/restaurant_favorite';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
            child: Text(
              "Favorite Restaurants",
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer2<DatabaseProvider, DatabaseProvider>(
                builder: (context, state, stateDb, _) {
              if (state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.favoriteRestaurant.length,
                  padding: EdgeInsets.only(top: 5),
                  itemBuilder: (context, index) {
                    var resto = state.favoriteRestaurant[index];
                    var image = resto.pictureId.toString();

                    return FutureBuilder<bool>(
                        future: stateDb.isFavorite(resto.id),
                        builder: (context, snapshot) {
                          var isFavorite = snapshot.data ?? false;
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RestaurantDetailScreen.routeName,
                                arguments: resto.id.toString(),
                              );
                            },
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Center(
                                          child: Image.network(
                                            'https://restaurant-api.dicoding.dev/images/small/$image',
                                          ),
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              resto.name,
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  size: 15,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  resto.city,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    size: 15,
                                                    color: Colors.yellow),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  resto.rating.toString(),
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: (isFavorite)
                                          ? IconButton(
                                              icon: Icon(Icons.favorite),
                                              color: Colors.red,
                                              onPressed: () => stateDb
                                                  .removeFavorite(resto.id),
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.favorite_border),
                                              color: Colors.green,
                                              onPressed: () {
                                                stateDb.addFavorite(resto);
                                              }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                );
              } else if (state.state == ResultState.NoData) {
                return Center(
                  child: Text(
                    "Restaurant Favorite Anda Kosong",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              } else if (state.state == ResultState.Error) {
                return Center(
                  child: Text(
                    "Terjadi Error, Silahkan Hubungi Developer",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(""),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
