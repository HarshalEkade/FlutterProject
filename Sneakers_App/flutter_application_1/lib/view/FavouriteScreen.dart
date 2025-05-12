import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/Navigatorbar.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Shoe> favoriteItems;

  // Constructor to receive the favorite items list
  const FavoritesScreen({Key? key, required this.favoriteItems})
      : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Shoe> favoriteItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favorites",
          style: GoogleFonts.raleway(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteItems.length,
        itemBuilder: (context, index) {
          Shoe shoe = widget.favoriteItems[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 5, bottom: 20, top: 20),
                child: Container(
                  height: 170,
                  width: 390,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        offset: const Offset(
                            4, 4), // Horizontal and vertical offset
                        blurRadius: 10, // Blur radius
                        spreadRadius: 2, // Spread radius
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.favorite, color: Colors.red),
                          ),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            padding: const EdgeInsets.only(left: 10),
                            width: 190,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                            ),
                            child: Image.network(
                              shoe.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      //  const Spacer(),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 50, right: 12, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shoe.name,
                                style: GoogleFonts.raleway(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromRGBO(43, 43, 43, 1)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "₹${shoe.price}",
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(43, 43, 43, 1)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: navigatorBar(context, favoriteItems),
    );
  }
}
