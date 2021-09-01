import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/models/restaurant_query_model.dart';
import 'package:restaurant_app/services/api_services.dart';
import 'package:restaurant_app/view/restaurant_detail.dart';

class RestaurantSearchScreen extends StatefulWidget {
  const RestaurantSearchScreen({Key? key}) : super(key: key);

  @override
  _RestaurantSearchScreenState createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(
                height: 34,
              ),
              Text(
                "Search",
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: 278,
                      height: 45,
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          ApiServices().getRestaurantQuery(_search.text);

                          setState(() {});
                        },
                        child: Icon(Icons.search),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<RestaurantQuery>(
                future: ApiServices().getRestaurantQuery(_search.text),
                builder: (context, AsyncSnapshot snapshot) {
                  var state = snapshot.connectionState;
                  if (state != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      return (snapshot.data.founded == 0)
                          ? Center(
                              child: Text(
                                "Restoran Tidak Ditemukan",
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
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors
                                                                .grey[600],
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
                                                        style:
                                                            GoogleFonts.poppins(
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
            ],
          ),
        ),
      ),
    );
  }
}
