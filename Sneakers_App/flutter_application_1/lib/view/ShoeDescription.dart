import 'dart:developer';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Navigatorbar.dart';
import 'package:flutter_application_1/view/customsnackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/ShoeModel.dart';

class Shoedescription extends StatefulWidget {
  final Shoe shoe; // Add the shoe parameter to the constructor

  // Constructor that takes a Shoe object
  const Shoedescription({super.key, required this.shoe});

  @override
  State<Shoedescription> createState() => _ShoediscriptionState();
}

class _ShoediscriptionState extends State<Shoedescription> {
  int _selectedSizeIndex = -1;
  List<Shoe> favoriteItems = [];
  List<Shoe> listData = [];
  bool isLoading = false;

  void _selectSize(int index) {
    setState(() {
      _selectedSizeIndex = index; // Update the selected index
    });
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //CART FIREBASE
  Future<void> addShoe(
      {String? name,
      String? price,
      String? imagePath,
      String? description,
      String? size}) async {
    try {
      await firestore.collection('CartShoes').add({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
        'size': size,
      });
       CustomSnackbar.showCustomSnackbar(
        message: "Shoe Added To Cart Successfully",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
       CustomSnackbar.showCustomSnackbar(
        message: 'Failed to add shoe to cart : $e',
        context: context,
        icon: Icons.check_circle,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Set isLoading to false because we are passing the data directly
  }

  ///List get getItems => _favoriteItems();
  void toggleFavourite(Shoe shoe) {
    setState(() {
      if (favoriteItems.contains(shoe)) {
        favoriteItems.remove(shoe);
      } else {
        favoriteItems.add(shoe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the shoe data passed to the widget
    Shoe shoe = widget.shoe;
    log("description: ${shoe.name}"); // Get the shoe object from the widget
    log("description: ${shoe.price}");
    log("description: ${shoe.description}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sneakers Shop",
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
          itemCount: 1,
          itemBuilder: (context, index) {
            // physics: BouncingScrollPhysics(),

            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Container(
                    width: 400,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: shoe.imagePath.isNotEmpty
                        ? Image.network(
                            shoe.imagePath,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, size: 100);
                            },
                          )
                        : const Icon(Icons.image_not_supported, size: 100),
                  ),
                  const SizedBox(height: 12),
                  // Shoe Name
                  Container(
                    // height: 50,
                    child: Text(
                      shoe.name, // Displaying the dynamic shoe name
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: const Color.fromRGBO(43, 43, 43, 1),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Price
                  Text(
                    "MRP : ₹${shoe.price}",
                    style: GoogleFonts.quicksand(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Description
                  Container(
                    // color: Colors.amber,
                    //height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      shoe.description,
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: const Color.fromRGBO(112, 123, 129, 1),
                      ),
                      //  overflow: TextOverflow.ellipsis, // Show ellipsis for long text
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),

                  Text(
                    "Size : ${_selectedSizeIndex >= 0 ? _selectedSizeIndex + 5 : ''}", // Displaying the dynamic shoe name
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: const Color.fromRGBO(43, 43, 43, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(8, (index) {
                        return GestureDetector(
                          onTap: () {
                            _selectSize(index); // Update the selected size
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _selectedSizeIndex == index
                                  ? Colors.blue
                                  : Colors.white,
                              border: Border.all(
                                  color: const Color.fromARGB(255, 2, 12, 30)),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 5}',
                                style: GoogleFonts.raleway(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  // Favorite & Add to Cart buttons
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 53, top: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(217, 217, 217, 0.4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              toggleFavourite(Shoe(
                                name: shoe.name,
                                imagePath: shoe.imagePath,
                                price: shoe.price,
                                description: shoe.description,
                                size: '',
                              ));
                              setState(() {});
                            },
                            child: Icon(
                              favoriteItems.contains(Shoe(
                                name: shoe.name,
                                imagePath: shoe.imagePath,
                                price: shoe.price,
                                description: shoe.description,
                                size: '',
                              ))
                                  ? Icons.favorite
                                  : Icons.favorite_outline_outlined,
                              color: favoriteItems.contains(Shoe(
                                name: shoe.name,
                                imagePath: shoe.imagePath,
                                price: shoe.price,
                                description: shoe.description,
                                size: '',
                              ))
                                  ? Colors.red
                                  : const Color.fromRGBO(41, 45, 50, 1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 70),
                        ElevatedButton(
                          onPressed: () {
                            addShoe(
                              name: shoe.name,
                              imagePath: shoe.imagePath,
                              price: shoe.price,
                              description: shoe.description,
                              size: '${_selectedSizeIndex + 5}',
                            );
                            setState(() {});
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(const Color.fromRGBO(13, 110, 253,1)),
                          ),
                          child: Text(
                            "Add To Cart",
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: navigatorBar(context, favoriteItems),
);
}
}