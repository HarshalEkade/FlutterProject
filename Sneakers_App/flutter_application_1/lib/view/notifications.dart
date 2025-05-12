// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/ShoeModel.dart';
// import 'package:flutter_application_1/view/Navigatorbar.dart';
// import 'package:flutter_application_1/view/ShoeDescription.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Notifications extends StatefulWidget {
//   const Notifications({super.key});

//   @override
//   State<Notifications> createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {
//   List<Shoe> listData = [];
//   List<Shoe> favoriteItems = [];

//   List<String> msgList = [
//     "Step into Style with Our Latest Collection!",
//     "Fresh Deals on Trendy Shoes Await!",
//     "New Arrivals, Hot Discounts!",
//     "Upgrade Your Look with Our New Offers!",
//     "Comfort Meets Fashion: Explore Now!",
//     "Don’t Miss Out on Our Exclusive Shoe Deals!",
//     "Step Up Your Game with Fresh Kicks!",
//     "Limited Time Offers on Must-Have Shoes!",
//     "New Trends, Great Prices – Shop Today!",
//     "Discover Comfort & Style in Every Step!"
//   ];

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(seconds: 0), () async {
//       List<QuerySnapshot> shoes = [
//         await FirebaseFirestore.instance.collection("MenShoes").get(),
//         await FirebaseFirestore.instance.collection("WomenShoes").get(),
//         await FirebaseFirestore.instance.collection("KidsShoes").get()
//       ];

//       for (var query in shoes) {
//         for (var doc in query.docs) {
//           listData.add(Shoe(
//             name: doc['name'],
//             imagePath: doc['imageUrl'],
//             price: doc['price'],
//             description: doc['description'],
//             size: '',
//           ));
//         }
//       }
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Notifications",
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
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Recent",
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//                 color: const Color.fromRGBO(43, 43, 43, 1),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: listData.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) {
//                             return Shoedescription(shoe: listData[index]);
//                           },
//                         ));
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: const Color.fromARGB(255, 239, 236, 236),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 90,
//                               width: 110,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: const Color.fromRGBO(247, 247, 249, 1),
//                               ),
//                               child: Image.network(
//                                 listData[index].imagePath,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     msgList[index % msgList.length],
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16,
//                                       color:
//                                           const Color.fromRGBO(13, 110, 253, 1),
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           listData[index].name,
//                                           style: GoogleFonts.poppins(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 14,
//                                             color: const Color.fromRGBO(
//                                                 43, 43, 43, 1),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(
//                                         "₹${listData[index].price}",
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14,
//                                           color:
//                                               Color.fromRGBO(112, 123, 129, 1),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: navigatorBar(context, favoriteItems),
// );
// }
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/Navigatorbar.dart';
import 'package:flutter_application_1/view/ShoeDescription.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Shoe> listData = [];
  List<Shoe> favoriteItems = [];

  List<String> msgList = [
    "Step into Style with Our Latest Collection!",
    "Fresh Deals on Trendy Shoes Await!",
    "New Arrivals, Hot Discounts!",
    "Upgrade Your Look with Our New Offers!",
    "Comfort Meets Fashion: Explore Now!",
    "Don’t Miss Out on Our Exclusive Shoe Deals!",
    "Step Up Your Game with Fresh Kicks!",
    "Limited Time Offers on Must-Have Shoes!",
    "New Trends, Great Prices – Shop Today!",
    "Discover Comfort & Style in Every Step!"
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      List<QuerySnapshot> shoes = [
        await FirebaseFirestore.instance.collection("MenShoes").get(),
        await FirebaseFirestore.instance.collection("WomenShoes").get(),
        await FirebaseFirestore.instance.collection("KidsShoes").get()
      ];

      for (var query in shoes) {
        for (var doc in query.docs) {
          listData.add(Shoe(
            name: doc['name'],
            imagePath: doc['imageUrl'],
            price: doc['price'],
            description: doc['description'],
            size: '',
          ));
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color.fromRGBO(43, 43, 43, 1),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: listData.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Shoedescription(shoe: listData[index]);
                          },
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              offset: const Offset(-2, -2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              width: 110,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromRGBO(247, 247, 249, 1),
                              ),
                              child: Image.network(
                                listData[index].imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msgList[index % msgList.length],
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color:
                                          const Color.fromRGBO(13, 110, 253, 1),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          listData[index].name,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: const Color.fromRGBO(
                                                43, 43, 43, 1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "₹${listData[index].price}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(112, 123, 129, 1),
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
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: navigatorBar(context, favoriteItems),
    );
  }
}
