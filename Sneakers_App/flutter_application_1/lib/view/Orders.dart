import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/checkout.dart';
import 'package:flutter_application_1/view/customsnackbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Shoe> listData = [];

  //ORDERS FIREBASE
  Future<void> deleteOrderedShoes(String id) async {
    try {
      await firestore.collection('ShoeOrders').doc(id).delete();
      CustomSnackbar.showCustomSnackbar(
        message: "Shoe Deleted Successfully!",
        context: context,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to delete shoe: $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      QuerySnapshot shoes =
          await FirebaseFirestore.instance.collection("ShoeOrders").get();

      for (int i = 0; i <= shoes.docs.length; i++) {
        listData.add(Shoe(
            name: shoes.docs[i]['name'],
            imagePath: shoes.docs[i]['imageUrl'],
            price: shoes.docs[i]['price'],
            description: shoes.docs[i]['description'],
            size: shoes.docs[i]['size']));
      }
      //log("LIST DATA :- ${listData.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('ShoeOrders').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
        
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No shoes available.'));
              }
        
              final cartshoes = snapshot.data!.docs;
              for (var shoe in cartshoes) {
                final data = shoe.data() as Map<String, dynamic>;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromRGBO(26, 37, 48, 1),
                    ),
                  ),
                  const SizedBox(height: 20),
                 
                  Container(
                    height:700,
                    child: ListView.builder(
                        itemCount: cartshoes.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final shoe = cartshoes[index];
                          final id = shoe.id;
                          final data = shoe.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      deleteOrderedShoes(id);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 60,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        color: const Color.fromRGBO(
                                            255, 25, 0, 1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/images/delete_icon.png"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(
                                      255, 255, 255, 255),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.2), // Shadow color
                                      offset: const Offset(4,
                                          4), // Horizontal and vertical offset
                                      blurRadius: 10, // Blur radius
                                      spreadRadius: 2, // Spread radius
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10),
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromRGBO(
                                              255, 237, 237, 1),
                                        ),
                                        child: Image.network(
                                          data['imageUrl'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Text(
                                            data['name'],
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: const Color.fromRGBO(
                                                  26, 37, 48, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "MRP : ₹${data['price']}",
                                                style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      26, 37, 48, 1),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        right: 26),
                                                child: Text(
                                                  data['size'] != null
                                                      ? "Size : ${data['size']}"
                                                      : "",
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        26, 37, 48, 1),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }),
     ),
);
}
}