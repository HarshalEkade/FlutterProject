// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/ShoeModel.dart';
// import 'package:flutter_application_1/view/checkout.dart';
// import 'package:flutter_application_1/view/customsnackbar.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   List<Shoe> listData = [];
//   Map<String, int> count = {};
//   int itemCount = 0;

//   //SUBTOTAL
//   double calculateTotalSum(List<QueryDocumentSnapshot> cartshoes) {
//     double totalSum = 0.0;
//     for (var shoe in cartshoes) {
//       final data = shoe.data() as Map<String, dynamic>;
//       final price = double.tryParse(data['price'].toString()) ?? 0.0;
//       final quantity = count[shoe.id] ?? 1;
      
      
//       totalSum += price * quantity;
//     }
//     return totalSum;
//   }

//   //DELIVERY COST
//   double deliveryCost(double totalSum) {
//     double deliveryCharges = 0.0;
//     if (totalSum > 5000 && totalSum <= 10000) {
//       deliveryCharges = 40;
//     } else if (totalSum > 10000 && totalSum <= 20000) {
//       deliveryCharges = 75;
//     } else if (totalSum > 20000 && totalSum <= 50000) {
//       deliveryCharges = 100;
//     } else {
//       deliveryCharges = 0;
//     }
//     return deliveryCharges;
//   }

//   Future<void> deleteCartShoes(String id) async {
//     try {
//       await firestore.collection('CartShoes').doc(id).delete();
//       CustomSnackbar.showCustomSnackbar(
//         message: "Shoe Deleted Successfully!",
//         context: context,
//         icon: Icons.check_circle,
//       );
//     } catch (e) {
//       CustomSnackbar.showCustomSnackbar(
//         message: "Failed to delete shoe: $e",
//         context: context,
//         icon: Icons.dangerous_rounded,
//       );
//     }
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(seconds: 0), () async {
//       QuerySnapshot shoes =
//           await FirebaseFirestore.instance.collection("CartShoes").get();

//       for (int i = 0; i <= shoes.docs.length; i++) {
//         listData.add(Shoe(
//             name: shoes.docs[i]['name'],
//             imagePath: shoes.docs[i]['imageUrl'],
//             price: shoes.docs[i]['price'],
//             description: shoes.docs[i]['description'],
//             size: shoes.docs[i]['size']));
//       }
//       //log("LIST DATA :- ${listData.length}");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Cart",
//           style: GoogleFonts.raleway(
//             fontWeight: FontWeight.w600,
//             fontSize: 25,
//             color: const Color.fromRGBO(255, 255, 255, 1),
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
//         iconTheme: const IconThemeData(
//           color: Color.fromRGBO(255, 255, 255, 1),
//         ),
//       ),
//       backgroundColor: const Color.fromARGB(255, 241, 241, 241),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ///CARDS
//             StreamBuilder<QuerySnapshot>(
//                 stream: firestore.collection('CartShoes').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(child: Text('No shoes available.'));
//                   }

//                   final cartshoes = snapshot.data!.docs;
//                   for (var shoe in cartshoes) {
//                     if (!count.containsKey(shoe.id)) {
//                       final data = shoe.data() as Map<String, dynamic>;
//                       count[shoe.id] = data['quantity'] ??
//                           1;
//                     }
//                   }

//                   final totalSum = calculateTotalSum(cartshoes);
//                   final deliveryPrice = deliveryCost(totalSum);
                  

//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${cartshoes.length+itemCount} Items",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 18,
//                           color: Color.fromRGBO(26, 37, 48, 1),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Container(
//                         height: 490,
//                         child: ListView.builder(
//                             itemCount: cartshoes.length,
//                             shrinkWrap: true,
//                             physics: const BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               final shoe = cartshoes[index];
//                               final id = shoe.id;
//                               final data = shoe.data() as Map<String, dynamic>;

//                               // log("Cart Shoe Data : ${data['description']}");

//                               if (!count.containsKey(id)) {
//                                 count[id] =
//                                     data['quantity'] ?? 1;
                                    
//                               }

//                               return Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Slidable(
//                                   startActionPane: ActionPane(
//                                     motion: const ScrollMotion(),
//                                     children: [
//                                       const SizedBox(width: 110),
//                                       Container(
//                                         height: 120,
//                                         width: 60,
//                                         padding: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: const Color.fromRGBO(
//                                               13, 110, 253, 1),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   count[id] =
//                                                       (count[id] ?? 1) + 1;
//                                                       itemCount++;
//                                                   //log("COUNT : ${count[id]}");
//                                                 });
//                                               },
//                                               child: const Icon(
//                                                 Icons.add,
//                                                 color: Color.fromRGBO(
//                                                     255, 255, 255, 1),
//                                               ),
//                                             ),
//                                             Text(
//                                               "${count[id] ?? 1}",
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 14,
//                                                 color: Color.fromRGBO(
//                                                     255, 255, 255, 1),
//                                               ),
//                                             ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   if ((count[id] ?? 1) > 1) {
//                                                     count[id] =
//                                                         (count[id] ?? 1) - 1;
//                                                   }
//                                                   itemCount--;
//                                                 });
//                                               },
//                                               child: const Icon(
//                                                 Icons.remove,
//                                                 color: Color.fromRGBO(
//                                                     255, 255, 255, 1),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   endActionPane: ActionPane(
//                                     motion: const ScrollMotion(),
//                                     children: [
//                                       const SizedBox(width: 10),
//                                       GestureDetector(
//                                         onTap: () {
//                                           deleteCartShoes(id);
//                                           setState(() {});
//                                         },
//                                         child: Container(
//                                           height: 120,
//                                           width: 60,
//                                           padding: const EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             color: const Color.fromRGBO(
//                                                 255, 25, 0, 1),
//                                           ),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Image.asset(
//                                                   "assets/images/delete_icon.png"),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Container(
//                                     height: 120,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color.fromARGB(
//                                           255, 255, 255, 255),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black
//                                               .withOpacity(0.2), // Shadow color
//                                           offset: const Offset(4,
//                                               4), // Horizontal and vertical offset
//                                           blurRadius: 10, // Blur radius
//                                           spreadRadius: 2, // Spread radius
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 10),
//                                           child: Container(
//                                             clipBehavior: Clip.antiAlias,
//                                             height: 100,
//                                             width: 100,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               color: const Color.fromRGBO(
//                                                   255, 237, 237, 1),
//                                             ),
//                                             child: Image.network(
//                                               data['imageUrl'],
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 20),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(height: 20),
//                                               Text(
//                                                 data['name'],
//                                                 style: GoogleFonts.poppins(
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: 18,
//                                                   color: const Color.fromRGBO(
//                                                       26, 37, 48, 1),
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 10),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "MRP : ₹${data['price']}",
//                                                     style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       fontSize: 16,
//                                                       color: Color.fromRGBO(
//                                                           26, 37, 48, 1),
//                                                     ),
//                                                   ),
//                                                   const Spacer(),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 26),
//                                                     child: Text(
//                                                       data['size'] != null
//                                                           ? "Size : ${data['size']}"
//                                                           : "",
//                                                       style: const TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         fontSize: 16,
//                                                         color: Color.fromRGBO(
//                                                             26, 37, 48, 1),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                       const SizedBox(height: 20),

//                       ///TOTAL COST
//                       Row(
//                         children: [
//                           Text(
//                             "Subtotal",
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: const Color.fromRGBO(43, 43, 43, 1),
//                             ),
//                           ),
//                           const Spacer(),
//                           Text(
//                             "₹${totalSum.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: Color.fromRGBO(43, 43, 43, 1),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Text(
//                             "Delivery",
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: const Color.fromRGBO(43, 43, 43, 1),
//                             ),
//                           ),
//                           const Spacer(),
//                           Text(
//                             "₹${deliveryPrice.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: Color.fromRGBO(43, 43, 43, 1),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           color: Color.fromRGBO(43, 43, 43, 1),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Text(
//                             "Total Cost",
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: const Color.fromRGBO(43, 43, 43, 1),
//                             ),
//                           ),
//                           const Spacer(),
//                           Text(
//                             "₹${(totalSum + deliveryPrice).toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: Color.fromRGBO(13, 110, 253, 1),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       ///CHECKOUT BUTTON
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return Checkout(
//                                     subtotal: totalSum,
//                                     delivery: deliveryPrice);
//                               },
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(250, 50),
//                           backgroundColor:
//                               const Color.fromRGBO(13, 110, 253, 1),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Checkout",
//                             style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 18,
//                               color: const Color.fromRGBO(255, 255, 255, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//           ],
//         ),
//      ),
// );
// }
// }
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/checkout.dart';
import 'package:flutter_application_1/view/customsnackbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Shoe> listData = [];
  Map<String, int> count = {};
  int itemCount = 0;

  //ORDERS FIREBASE
  Future<void> addShoe(List<QueryDocumentSnapshot> cartshoes) async {
    try {
      for (var shoe in cartshoes) {
        final data = shoe.data() as Map<String, dynamic>;
        final name = data['name']?.toString() ?? '';
        final price = double.tryParse(data['price'].toString()) ?? 0.0;
        final imagePath = data['imageUrl']?.toString() ?? '';
        log("IMAGE LINK : $imagePath");
        final size = data['size']?.toString() ?? '';

        await firestore.collection('ShoeOrders').add({
          'name': name,
          'price': price,
          'imageUrl': imagePath,
          'size': size,
        });
        // CustomSnackbar.showCustomSnackbar(
        //   message: "Shoe Ordered Successfully!",
        //   context: context,
        //   icon: Icons.check_circle,
        // );
      }
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(
        message: "Failed to order shoe : $e",
        context: context,
        icon: Icons.dangerous_rounded,
      );
    }
  }

  //SUBTOTAL
  double calculateTotalSum(List<QueryDocumentSnapshot> cartshoes) {
    double totalSum = 0.0;
    for (var shoe in cartshoes) {
      final data = shoe.data() as Map<String, dynamic>;
      final price = double.tryParse(data['price'].toString()) ?? 0.0;
      final quantity = count[shoe.id] ?? 1;

      totalSum += price * quantity;
    }
    return totalSum;
  }

  //DELIVERY COST
  double deliveryCost(double totalSum) {
    double deliveryCharges = 0.0;
    if (totalSum > 5000 && totalSum <= 10000) {
      deliveryCharges = 40;
    } else if (totalSum > 10000 && totalSum <= 20000) {
      deliveryCharges = 75;
    } else if (totalSum > 20000 && totalSum <= 50000) {
      deliveryCharges = 100;
    } else {
      deliveryCharges = 0;
    }
    return deliveryCharges;
  }

  Future<void> deleteCartShoes(String id) async {
    try {
      await firestore.collection('CartShoes').doc(id).delete();
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
          await FirebaseFirestore.instance.collection("CartShoes").get();

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
          "My Cart",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///CARDS
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('CartShoes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No shoes available.'));
                  }

                  final cartshoes = snapshot.data!.docs;
                  for (var shoe in cartshoes) {
                    if (!count.containsKey(shoe.id)) {
                      final data = shoe.data() as Map<String, dynamic>;
                      count[shoe.id] = data['quantity'] ?? 1;
                    }
                  }

                  final totalSum = calculateTotalSum(cartshoes);
                  final deliveryPrice = deliveryCost(totalSum);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cartshoes.length + itemCount} Items",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color.fromRGBO(26, 37, 48, 1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 490,
                        child: ListView.builder(
                            itemCount: cartshoes.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final shoe = cartshoes[index];
                              final id = shoe.id;
                              final data = shoe.data() as Map<String, dynamic>;

                              // log("Cart Shoe Data : ${data['description']}");

                              if (!count.containsKey(id)) {
                                count[id] = data['quantity'] ?? 1;
                              }

                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Slidable(
                                      startActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          const SizedBox(width: 110),
                                          Container(
                                            height: 120,
                                            width: 60,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromRGBO(
                                                  13, 110, 253, 1),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      count[id] =
                                                          (count[id] ?? 1) + 1;
                                                      itemCount++;
                                                      //log("COUNT : ${count[id]}");
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                  ),
                                                ),
                                                Text(
                                                  "${count[id] ?? 1}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if ((count[id] ?? 1) >
                                                          1) {
                                                        count[id] =
                                                            (count[id] ?? 1) -
                                                                1;
                                                      }
                                                      itemCount--;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              deleteCartShoes(id);
                                              
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                  0.2), // Shadow color
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
                                              padding: const EdgeInsets.only(
                                                  left: 10),
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color:
                                                          const Color.fromRGBO(
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
                                                            const EdgeInsets
                                                                .only(
                                                                right: 26),
                                                        child: Text(
                                                          data['size'] != null
                                                              ? "Size : ${data['size']}"
                                                              : "",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    26,
                                                                    37,
                                                                    48,
                                                                    1),
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
                                  ],
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 20),

                      ///TOTAL COST
                      Row(
                        children: [
                          Text(
                            "Subtotal",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: const Color.fromRGBO(43, 43, 43, 1),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹${totalSum.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromRGBO(43, 43, 43, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Delivery",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: const Color.fromRGBO(43, 43, 43, 1),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹${deliveryPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromRGBO(43, 43, 43, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(43, 43, 43, 1),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Total Cost",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: const Color.fromRGBO(43, 43, 43, 1),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹${(totalSum + deliveryPrice).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromRGBO(13, 110, 253, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ///CHECKOUT BUTTON
                      ElevatedButton(
                        onPressed: () {
                          addShoe(cartshoes);
                          // var index;
                          // addShoe(
                          //   name: cartshoes[index]['name'],
                          //   imagePath: cartshoes[index]['imagePath'],
                          //   price: cartshoes[index]['price'],
                          //   size: cartshoes[index]['size'],
                          // );
                          //setState(() {});

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Checkout(
                                    subtotal: totalSum,
                                    delivery: deliveryPrice);
                              },
                            ),
                          );
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                          backgroundColor:
                              const Color.fromRGBO(13, 110, 253, 1),
                        ),
                        child: Center(
                          child: Text(
                            "Checkout",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
     ),
);
}
}