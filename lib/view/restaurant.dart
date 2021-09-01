import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/services/api_services.dart';
import 'package:restaurant_app/view/restaurant_detail.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiServices()),
      child: Scaffold(
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
            body: Consumer<RestaurantProvider>(builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                return ListView.builder(
                  itemCount: state.resultList.restaurants.length,
                  padding: EdgeInsets.only(top: 5),
                  itemBuilder: (context, index) {
                    var resto = state.resultList.restaurants[index];
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
              } else if (state.state == ResultState.NoData) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state.state == ResultState.Error) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text(""),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
