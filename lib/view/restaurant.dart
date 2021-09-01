import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/models/restaurant_api_model.dart';
import 'package:restaurant_app/services/api_services.dart';
import 'package:restaurant_app/view/restaurant_detail.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late Future<RestaurantList> _resto;
  @override
  void initState() {
    super.initState();
    _resto = ApiServices().getRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                backgroundColor: Colors.green,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/banner.jpg',
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    "RestoKu App",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 1.5),
                              color: Colors.black.withOpacity(0.4),
                            )
                          ]),
                    ),
                  ),
                  titlePadding: EdgeInsets.only(left: 16, bottom: 10),
                ),
              )
            ];
          },
          body: FutureBuilder<RestaurantList>(
            future: _resto,
            builder: (context, AsyncSnapshot snapshot) {
              var state = snapshot.connectionState;
              if (state != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.restaurants.length,
                    padding: EdgeInsets.only(top: 5),
                    itemBuilder: (context, index) {
                      var resto = snapshot.data.restaurants[index];
                      var image = resto.pictureId.toString();
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RestaurantDetailScreen(
                                    restoId: resto.id.toString());
                              },
                            ),
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
                                                  fontWeight: FontWeight.w400,
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
                                                size: 15, color: Colors.yellow),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              resto.rating.toString(),
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Text('');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
