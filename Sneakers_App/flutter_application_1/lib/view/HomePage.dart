import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/CategoryScreen.dart';
import 'package:flutter_application_1/view/DrawerScreen.dart';
import 'package:flutter_application_1/view/Navigatorbar.dart';
import 'package:flutter_application_1/view/customsnackbar.dart';
import 'package:flutter_application_1/view/my_cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'FavouriteScreen.dart';
import 'ShoeDescription.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key, email, List<Shoe>? favoriteItems});
  final List<Shoe> favoriteItems = [];

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State {
  List<Shoe> favoriteItems = [];
  List<Shoe> listData = [];
  List<Shoe> sportsShoeList = [];
  List imageList = [
    {"id": 1, "image_path": 'assets/ads/ad.jpg'},
    {"id": 2, "image_path": 'assets/ads/ad2.jpg'},
    {"id": 3, "image_path": 'assets/ads/ad3.jpg'},
    {"id": 4, "image_path": 'assets/ads/ad4.jpg'},
    {"id": 5, "image_path": 'assets/ads/ad5.jpg'},
  ];
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();
  int currentindex = 0;
  late Future<Map<String, dynamic>> userProfile;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //CART FIREBASE
  Future<void> addShoe(
      {String? name,
      String? price,
      String? imagePath,
      String? description}) async {
    try {
      await firestore.collection('CartShoes').add({
        'name': name,
        'price': price,
        'imageUrl': imagePath,
        'description': description,
      });
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Added To Cart Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to add shoe to cart : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      QuerySnapshot shoes =
          await FirebaseFirestore.instance.collection("MenShoes").get();

      for (int i = 0; i < shoes.docs.length; i++) {
        listData.add(Shoe(
          name: shoes.docs[i]['name'],
          imagePath: shoes.docs[i]['imageUrl'],
          price: shoes.docs[i]['price'],
          description: shoes.docs[i]['description'],
          size: '',
        ));
      }
      setState(() {});
      // log("MEN LIST DATA :- ${listData.length}");
    });

    //WOMEN SHOES
    Future.delayed(const Duration(seconds: 0), () async {
      QuerySnapshot shoes =
          await FirebaseFirestore.instance.collection("WomenShoes").get();

      for (int i = 0; i < shoes.docs.length; i++) {
        listData.add(Shoe(
          name: shoes.docs[i]['name'],
          imagePath: shoes.docs[i]['imageUrl'],
          price: shoes.docs[i]['price'],
          description: shoes.docs[i]['description'],
          size: '',
        ));
      }
      setState(() {});

      //log("WOMEN LIST DATA :- ${listData.length}");
    });

    //KIDS SHOES
    Future.delayed(const Duration(seconds: 0), () async {
      QuerySnapshot shoes =
          await FirebaseFirestore.instance.collection("KidsShoes").get();

      for (int i = 0; i < shoes.docs.length; i++) {
        listData.add(Shoe(
          name: shoes.docs[i]['name'],
          imagePath: shoes.docs[i]['imageUrl'],
          price: shoes.docs[i]['price'],
          description: shoes.docs[i]['description'],
          size: '',
        ));
      }
      setState(() {});
      //log("KIDS LIST DATA :- ${listData.length}");
    });

    //SPORTS SHOES
    Future.delayed(const Duration(seconds: 0), () async {
      QuerySnapshot shoes =
          await FirebaseFirestore.instance.collection("SportsShoes").get();

      for (int i = 0; i < shoes.docs.length; i++) {
        sportsShoeList.add(Shoe(
          name: shoes.docs[i]['name'],
          imagePath: shoes.docs[i]['imageUrl'],
          price: shoes.docs[i]['price'],
          description: shoes.docs[i]['description'],
          size: '',
        ));
      }
      setState(() {});
      // log("SPORTS LIST DATA :- ${listData.length}");
    });

    userProfile = fetchUserProfile();
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not authenticated");
    }
    // Replace this with the actual Firestore document ID if needed
    var doc = await FirebaseFirestore.instance
        .collection("profileInfo")
        .doc(user.uid)
        .get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      throw Exception("Profile data not found");
    }
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

  // ignore: non_constant_identifier_names
  TextEditingController SearchController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FavoritesScreen(
                    favoriteItems: favoriteItems,
                  )),
        );
        break;
      default:
        break;
    }
  }

  String _searchTerm = "";
  List<Shoe> shoeList = [];

  List<Shoe> listData1 = [
    // Example data
    Shoe(
        name: "Running Shoe",
        imagePath: "url1",
        price: "\$100",
        description: "Great for running",
        size: ''),
    Shoe(
        name: "Casual Sneaker",
        imagePath: "url2",
        price: "\$80",
        description: "Everyday wear",
        size: ''),
    Shoe(
        name: "Formal Shoe",
        imagePath: "url3",
        price: "\$120",
        description: "Perfect for office",
        size: ''),
  ];

  List<Shoe> searchShoes(String searchTerm) {
    return shoeList
        .where((shoe) =>
            shoe.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
            shoe.price.toLowerCase().contains(searchTerm.toLowerCase()) ||
            shoe.description.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    SearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Shoe> filteredShoes = listData
        .where((shoe) =>
            shoe.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "Sneakers App",
            style: GoogleFonts.raleway(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    //log("LISTDATA LENGTH : ${listData.length}");
                    return const CartScreen();
                  }),
                );
                setState(() {});
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Row(
              children: [
                const Align(
                  alignment: Alignment.center,
                ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: TextField(
                      controller: SearchController,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      obscureText: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(106, 106, 106, 1),
                          weight: 14.33,
                        ),
                        hintText: "Looking for shoes",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromRGBO(106, 106, 106, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Colors.teal,
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 67, 64, 64), 
                                width: 1.8,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0, 
                          ),
                        ),
                      ),
                      onChanged: (value) => setState(
                        () => _searchTerm = value,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  print(currentindex);
                },
                child: Container(
                  height: 190,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: CarouselSlider(
                      items: imageList
                          .map((item) => Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ))
                          .toList(),
                      carouselController: carouselSliderController,
                      options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentindex = index;
                            });
                          })),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  print(entry);
                  print(entry.key);
                  return GestureDetector(
                    onTap: () =>
                        carouselSliderController.animateToPage(entry.key),
                    child: Container(
                      width: currentindex == entry.key ? 17 : 7,
                      height: 7,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentindex == entry.key
                              ? Colors.red
                              : Colors.teal),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 6),
            child: Text(
              "Select Category",
              style: GoogleFonts.raleway(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CategoryScreen(
                            collectionNames: const [
                              "MenShoes",
                              "WomenShoes",
                              "KidsShoes"
                            ],
                          );
                        }),
                      );
                    },
                    child: Container(
                      width: 108,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(13, 110, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Color.fromRGBO(0, 0, 0, 0.04)),
                          ]),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "All Shoes",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                              collectionNames: const ["MenShoes"]),
                        ),
                      );
                    },
                    child: Container(
                      width: 108,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(13, 110, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Color.fromRGBO(0, 0, 0, 0.04)),
                          ]),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Mens",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                              collectionNames: const ["WomenShoes"]),
                        ),
                      );
                    },
                    child: Container(
                      width: 108,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(13, 110, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Color.fromRGBO(0, 0, 0, 0.04)),
                          ]),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Womens",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                              collectionNames: const ["KidsShoes"]),
                        ),
                      );
                    },
                    child: Container(
                      width: 108,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(13, 110, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Color.fromRGBO(0, 0, 0, 0.04)),
                          ]),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Kids",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Text(
              "Popular Shoes",
              style: GoogleFonts.raleway(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredShoes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 290,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(4, 4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Favorite icon
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (favoriteItems
                                      .contains(filteredShoes[index])) {
                                    favoriteItems.remove(filteredShoes[index]);
                                  } else {
                                    favoriteItems.add(filteredShoes[index]);
                                  }
                                });
                              },
                              child: Icon(
                                favoriteItems.contains(filteredShoes[index])
                                    ? Icons.favorite
                                    : Icons.favorite_outline_outlined,
                                color:
                                    favoriteItems.contains(filteredShoes[index])
                                        ? Colors.red
                                        : const Color.fromRGBO(41, 45, 50, 1),
                              ),
                            ),
                          ),
                          // Shoe image and details
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 140,
                            width: 190,
                            padding: const EdgeInsets.only(left: 7),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Shoedescription(
                                      shoe: filteredShoes[index],
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                filteredShoes[index].imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 6),
                            child: Text(
                              "BEST SELLER",
                              style: TextStyle(
                                color: Colors.blue[400],
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 6),
                            child: Text(
                              filteredShoes[index].name,
                              style: const TextStyle(
                                color: Color.fromRGBO(106, 106, 106, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 6),
                                child: Text(
                                  "₹${filteredShoes[index].price}",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(44, 43, 43, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 37,
                                width: 40,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  color: Color.fromRGBO(13, 110, 253, 1),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    addShoe(
                                      name: filteredShoes[index].name,
                                      imagePath: filteredShoes[index].imagePath,
                                      price: filteredShoes[index].price,
                                      description:
                                          filteredShoes[index].description,
                                    );
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.add,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "New Arrivals",
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Container(
              width: 330,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(255, 255, 255, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    offset:
                        const Offset(4, 4), // Horizontal and vertical offset
                    blurRadius: 10, // Blur radius
                    spreadRadius: 2, // Spread radius
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Summer Sale",
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color.fromRGBO(59, 59, 59, 1)),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          "15% OFF",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 36,
                              color: Color.fromRGBO(103, 77, 197, 1)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.48,
                    height: 16.7,
                    child: Image.asset("assets/icons/Vector.png"),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 7),
                    height: 100,
                    width: 180,
                    child: Image.asset("assets/icons/pngwing.com (1).png"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Text(
              "Sports Shoes",
              style: GoogleFonts.raleway(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sportsShoeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 290,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            offset: const Offset(
                                4, 4), // Horizontal and vertical offset
                            blurRadius: 10, // Blur radius
                            spreadRadius: 2, // Spread radius
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Favorite icon
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (favoriteItems
                                      .contains(sportsShoeList[index])) {
                                    favoriteItems.remove(sportsShoeList[index]);
                                  } else {
                                    favoriteItems.add(sportsShoeList[index]);
                                  }
                                });
                              },
                              child: Icon(
                                favoriteItems.contains(sportsShoeList[index])
                                    ? Icons.favorite
                                    : Icons.favorite_outline_outlined,
                                color: favoriteItems
                                        .contains(sportsShoeList[index])
                                    ? Colors.red
                                    : const Color.fromRGBO(41, 45, 50, 1),
                              ),
                            ),
                          ),
                          // Shoe image and details
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 140,
                            width: 190,
                            padding: const EdgeInsets.only(left: 7),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Shoedescription(
                                      shoe: sportsShoeList[index],
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                sportsShoeList[index].imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 6),
                            child: Text(
                              "BEST SELLER",
                              style: TextStyle(
                                color: Colors.blue[400],
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 6),
                            child: Text(
                              sportsShoeList[index].name,
                              style: const TextStyle(
                                color: Color.fromRGBO(106, 106, 106, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 6),
                                child: Text(
                                  "₹${sportsShoeList[index].price}",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(44, 43, 43, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 37,
                                width: 40,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  color: Color.fromRGBO(13, 110, 253, 1),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    addShoe(
                                      name: sportsShoeList[index].name,
                                      imagePath:
                                          sportsShoeList[index].imagePath,
                                      price: sportsShoeList[index].price,
                                      description:
                                          sportsShoeList[index].description,
                                    );
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.add,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: navigatorBar(context, favoriteItems),
    );
  }
}
