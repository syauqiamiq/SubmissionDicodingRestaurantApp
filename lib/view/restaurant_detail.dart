import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/services/api_services.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String restoId;
  RestaurantDetailScreen({
    required this.restoId,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiServices(), id: restoId),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  var resto = state.resultDetail.restaurant;
                  var image = resto.pictureId.toString();
                  return ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                'https://restaurant-api.dicoding.dev/images/small/$image',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              resto.name,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 25,
                            color: Colors.red,
                          ),
                          SizedBox(width: 2),
                          Text(
                            resto.city,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              resto.description,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Foods",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: resto.menus.foods.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/foods.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        resto.menus.foods[index].name,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.yellow,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(2, 1.5),
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                )
                                              ]),
                                        ),
                                      ),
                                      Text(
                                        "IDR 15.000",
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.yellow,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(0.5, 0.5),
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Drinks",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: resto.menus.drinks.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/drinks.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        resto.menus.drinks[index].name,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.yellow,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(2, 1.5),
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                )
                                              ]),
                                        ),
                                      ),
                                      Text(
                                        "IDR 15.000",
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.yellow,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(0.5, 0.5),
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                    ],
                  );
                } else if (state.state == ResultState.NoData) {
                  return Center(
                    child: Text(
                      "Data Tidak Ditemukan",
                      textAlign: TextAlign.justify,
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
                      "Terjadi Error, Cek Koneksi Anda",
                      textAlign: TextAlign.justify,
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
