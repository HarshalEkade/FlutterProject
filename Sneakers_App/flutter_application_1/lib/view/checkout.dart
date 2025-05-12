// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/model/Debitcardmodel.dart';
// import 'package:flutter_application_1/model/ShoeModel.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Checkout extends StatefulWidget {
//   final double subtotal;
//   final double delivery;

//   const Checkout({
//     super.key,
//     required this.subtotal,
//     required this.delivery,
//   });

//   @override
//   State<Checkout> createState() => _CheckoutState();
// }

// class _CheckoutState extends State<Checkout> {
//   late Future<Map<String, dynamic>> userProfile;
//   List<Shoe> favoriteItems = [];
//   List<Debitcardmodel> debitInfo = [];

//   void submit(bool isEdit, [Debitcardmodel? obj]) {
//     if (cardnoController.text.trim().isNotEmpty &&
//         cvvController.text.trim().isNotEmpty &&
//         expiryController.text.trim().isNotEmpty &&
//         cardholdernameController.text.trim().isNotEmpty) {
//       if (isEdit) {
// //EDIT
//         obj!.cardno = cardnoController.text;
//         obj.cvv = cvvController.text;
//         obj.expiry = expiryController.text;
//         obj.cardholdername = cardholdernameController.text;
//       } else {
// //     ADD
//         debitInfo.add(
//           Debitcardmodel(
//             cardno: cardnoController.text,
//             cvv: cvvController.text,
//             expiry: expiryController.text,
//             cardholdername: cardholdernameController.text,
//           ),
//         );
//       }
//     }
//     Navigator.of(context).pop();
//     clearController();
//     setState(() {});
//   }

//   //BOTTOM SHEET
//   TextEditingController cardnoController = TextEditingController();
//   TextEditingController cvvController = TextEditingController();
//   TextEditingController expiryController = TextEditingController();
//   TextEditingController cardholdernameController = TextEditingController();

//   void clearController() {
//     cardholdernameController.clear();
//     expiryController.clear();
//     cvvController.clear();
//     cardnoController.clear();
//     setState(() {});
//   }

//   openBottomSheet(bool isEdit, [Debitcardmodel? debitInfo]) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       isDismissible: true,
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             left: 20,
//             right: 20,
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               const Center(
//                 child: Text(
//                   "Add New Card",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 20,
//                     color: Color.fromRGBO(42, 62, 243, 1),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Card No",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                   color: Color.fromRGBO(42, 62, 243, 1),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: cardnoController,
//                 keyboardType: TextInputType.number,
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                   LengthLimitingTextInputFormatter(16),
//                 ],
//                 decoration: InputDecoration(
//                   hintText: "xxxx xxxx xxxx xxxx",
//                   hintStyle: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.grey,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "CVV",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: Color.fromRGBO(42, 62, 243, 1),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         TextField(
//                           controller: cvvController,
//                           keyboardType: TextInputType.number,
//                           maxLength: 4,
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                             LengthLimitingTextInputFormatter(3),
//                           ],
//                           decoration: InputDecoration(
//                             counterText: "",
//                             hintText: "*",
//                             hintStyle: const TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Expiry Date",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: Color.fromRGBO(42, 62, 243, 1),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         TextField(
//                           controller: expiryController,
//                           keyboardType: TextInputType.number,
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                           inputFormatters: [
//                             FilteringTextInputFormatter
//                                 .digitsOnly, // Allow only digits
//                             LengthLimitingTextInputFormatter(
//                                 5), // Limit to 5 characters (MM/YY)
//                             ExpiryDateInputFormatter(), // Custom formatter for MM/YY
//                           ],
//                           decoration: InputDecoration(
//                             hintText: "MM/YY",
//                             hintStyle: const TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Card Holder Name",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                   color: Color.fromRGBO(42, 62, 243, 1),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: cardholdernameController,
//                 keyboardType: TextInputType.text,
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: "Enter full name",
//                   hintStyle: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.grey,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
//                     minimumSize: const Size(250, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (isEdit == true) {
//                       submit(true, debitInfo);
//                     } else {
//                       submit(false);
//                     }
//                   },
//                   child: const Text(
//                     "Add Card",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 20,
//                       color: Color.fromRGBO(252, 251, 251, 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   String? getUserEmail() {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return user.email; // Returns the user's email
//     } else {
//       throw Exception("User is not authenticated");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     userProfile = fetchUserProfile();
//   }

//   Future<Map<String, dynamic>> fetchUserProfile() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception("User is not authenticated");
//     }
//     // Replace this with the actual Firestore document ID if needed
//     var doc = await FirebaseFirestore.instance
//         .collection("profileInfo")
//         .doc(user.uid)
//         .get();

//     if (doc.exists) {
//       return doc.data() as Map<String, dynamic>;
//     } else {
//       throw Exception("Profile data not found");
//     }
//   }

//   bool isCardSelected = false;

//   void selectDebitCard(bool isSelected) {
//     setState(() {
//       isCardSelected = isSelected;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final subtotal = widget.subtotal;
//     final delivery = widget.delivery;
//     final totalCost = subtotal + delivery;

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
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           FutureBuilder<Map<String, dynamic>>(
//               future: userProfile,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 if (!snapshot.hasData || snapshot.data == null) {
//                   return const Center(child: Text("No Profile Data Found"));
//                 }

//                 var profileData = snapshot.data!;
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: const Color.fromRGBO(255, 255, 255, 1),
//                   ),
//                   child: Container(
//                     height: 500,
//                     child: ListView.builder(
//                         itemCount: 1,
//                         itemBuilder: (BuildContext context, index) {
//                           return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(height: 10),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8),
//                                   child: Text(
//                                     "Contact Information",
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 18,
//                                       color:
//                                           const Color.fromRGBO(26, 37, 48, 1),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height: 35,
//                                       width: 60,
//                                       child: Image.network(
//                                           "https://tse4.mm.bing.net/th?id=OIP.Yaficbwe3N2MjD2Sg0J9OgHaHa&pid=Api&P=0&h=180"),
//                                     ),
//                                     const SizedBox(width: 25),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "Name",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                             color: Color.fromRGBO(
//                                                 112, 123, 129, 1),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Text(
//                                           '${profileData['firstName'] ?? "No first name"} ${profileData['lastName'] ?? "No last name"}',
//                                           //profileData[index].mobileNumber,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 17,
//                                             color:
//                                                 Color.fromRGBO(26, 37, 48, 1),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 35),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 15),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       height: 30,
//                                       width: 60,
//                                       child: Image.network(
//                                           "https://tse1.mm.bing.net/th?id=OIP.uCEeUOoyzQMbDykSyBMicAHaHa&pid=Api&P=0&h=180"),
//                                     ),
//                                     const SizedBox(width: 23),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "Email",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 14,
//                                             color: Color.fromRGBO(
//                                                 112, 123, 129, 1),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Text(
//                                           getUserEmail() ?? '',
//                                           //profileData[index].mobileNumber,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 17,
//                                             color:
//                                                 Color.fromRGBO(26, 37, 48, 1),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 35),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 15),
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 15),
//                                       child: Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: Image.network(
//                                             "https://tse2.mm.bing.net/th?id=OIP.3sgvZ5c2XtrG_wjbb9mpFQHaHa&pid=Api&P=0&h=180"),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 35),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "Phone",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                             color: Color.fromRGBO(
//                                                 112, 123, 129, 1),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Text(
//                                           '+91 ${profileData['mobileNumber'] ?? "No number provided"}',
//                                           //profileData[index].mobileNumber,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 16,
//                                             color:
//                                                 Color.fromRGBO(26, 37, 48, 1),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 35),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 15),
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 14),
//                                       child: Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: Image.network(
//                                           "https://tse3.mm.bing.net/th?id=OIP.DIpIX8fLalOCZzAXZaImLwHaHa&pid=Api&P=0&h=180",
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 35),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "Address",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                             color: Color.fromRGBO(
//                                                 112, 123, 129, 1),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Text(
//                                           profileData['location'] ??
//                                               "No location provided",
//                                           //profileData[index].mobileNumber,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 16,
//                                             color:
//                                                 Color.fromRGBO(26, 37, 48, 1),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 35),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Text(
//                                   "Payment Method",
//                                   style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18,
//                                     color: const Color.fromRGBO(26, 37, 48, 1),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 20),
//                                         child: Container(
//                                           height: 30,
//                                           width: 30,
//                                           child: Image.network(
//                                               "https://tse1.mm.bing.net/th?id=OIP.CK9P44mPPsVjZRi3BNEPBQHaEK&pid=Api&P=0&h=180"),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 15),
//                                       const Text(
//                                         "Debit Card",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 16,
//                                           color: Color.fromRGBO(26, 37, 48, 1),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 205),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             openBottomSheet(false);
//                                             selectDebitCard(true);
//                                             setState(() {});
//                                           },
//                                           child: const Icon(
//                                             Icons.add_card_outlined,
//                                             color: Color.fromRGBO(7, 7, 7, 1),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 debitInfo.isNotEmpty && index < debitInfo.length
//                                     ? Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           color: const Color.fromRGBO(
//                                               234, 241, 245, 1),
//                                         ),
//                                         padding: const EdgeInsets.all(10),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "Cardholder Name : ${debitInfo[index].cardholdername}",
//                                                   style: GoogleFonts.poppins(
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 16,
//                                                     color: const Color.fromRGBO(
//                                                         26, 37, 48, 1),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 10),
//                                                 Text(
//                                                   "Card No : ${debitInfo[index].cardno}",
//                                                   style: GoogleFonts.poppins(
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 16,
//                                                     color: const Color.fromRGBO(
//                                                         26, 37, 48, 1),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     cardnoController.text =
//                                                         debitInfo[index].cardno;
//                                                     cardholdernameController
//                                                             .text =
//                                                         debitInfo[index]
//                                                             .cardholdername;
//                                                     cvvController.text =
//                                                         debitInfo[index].cvv;
//                                                     expiryController.text =
//                                                         debitInfo[index].expiry;

//                                                     openBottomSheet(
//                                                       true,
//                                                       debitInfo[index],
//                                                     );
//                                                   },
//                                                   child: const Icon(
//                                                     Icons.edit,
//                                                     color: Color.fromRGBO(
//                                                         7, 7, 7, 1),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     debitInfo.remove(
//                                                         debitInfo[index]);
//                                                     setState(() {});
//                                                   },
//                                                   child: const Icon(
//                                                     Icons.delete,
//                                                     color: Color.fromRGBO(
//                                                         7, 7, 7, 1),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : Center(
//                                         child: Text(
//                                           "No card available",
//                                           style: GoogleFonts.poppins(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16,
//                                             color: Color.fromRGBO(
//                                                 112, 123, 129, 1),
//                                           ),
//                                         ),
//                                       ),
//                               ]);
//                         }),
//                   ),
//                 );
//               }),

//           const Spacer(),

//           ///TOTAL COST
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "Subtotal",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: const Color.fromRGBO(43, 43, 43, 1),
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "₹$subtotal",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: Color.fromRGBO(43, 43, 43, 1),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Text(
//                     "Delivery",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: const Color.fromRGBO(43, 43, 43, 1),
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "₹$delivery",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: Color.fromRGBO(43, 43, 43, 1),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                   color: Color.fromRGBO(43, 43, 43, 1),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Text(
//                     "Total Cost",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: const Color.fromRGBO(43, 43, 43, 1),
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "₹$totalCost",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: Color.fromRGBO(13, 110, 253, 1),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               ///CHECKOUT BUTTON
//               ElevatedButton(
//                 onPressed: isCardSelected
//                     ? () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               title: Row(
//                                 children: [
//                                   const Icon(Icons.check_circle, color: Colors.green),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Payment Successful!',
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 22,
//                                       color: const Color.fromRGBO(43, 43, 43, 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               content: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Container(
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Color.fromRGBO(223, 239, 255, 1),
//                                     ),
//                                     child: Image.asset(
//                                         "assets/images/payment_successful_icon.png"),
//                                   ),
//                                   const SizedBox(height: 30),
//                                   Text(
//                                     "Your Payment Is Successful",
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 20,
//                                       color: const Color.fromRGBO(43, 43, 43, 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pop(); // Close the dialog
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color:
//                                           const Color.fromRGBO(13, 110, 253, 1),
//                                     ),
//                                     child: const Padding(
//                                       padding: EdgeInsets.all(10),
//                                       child: Text(
//                                         'Done',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     : null,
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(250, 50),
//                   backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Checkout",
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                       color: const Color.fromRGBO(255, 255, 255, 1),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class ExpiryDateInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String text = newValue.text;

//     // Remove any non-digit or non-slash characters
//     text = text.replaceAll(RegExp(r'[^\d/]'), '');

//     if (text.length > 5) {
//       // Enforce a maximum of 5 characters (MM/YY)
//       text = text.substring(0, 5);
//     }

//     if (text.length >= 1) {
//       // Ensure the first character is 0, 1, or 2
//       int firstDigit = int.tryParse(text[0]) ?? 0;
//       if (firstDigit > 1) {
//         text = '0$text';
//       }
//     }

//     if (text.length >= 2) {
//       // Validate the month (01-12)
//       int? month = int.tryParse(text.substring(0, 2));
//       if (month == null || month < 1 || month > 12) {
//         return oldValue; // Revert to the old value
//       }
//     }

//     if (text.length == 2 && !text.contains('/')) {
//       // Automatically append the slash after the month
//       text += '/';
//     }

//     if (text.length > 2 && text[2] != '/') {
//       // Force the slash to be at the third position
//       text = '${text.substring(0, 2)}/${text.substring(2)}';
//     }

//     if (text.length > 5) {
//       // Ensure the length does not exceed MM/YY
//       text = text.substring(0, 5);
//     }

//     return TextEditingValue(
//       text: text,
//       selection: TextSelection.collapsed(offset: text.length),
// );
// }
// }
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/Debitcardmodel.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatefulWidget {
  final double subtotal;
  final double delivery;

  const Checkout({
    super.key,
    required this.subtotal,
    required this.delivery,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late Future<Map<String, dynamic>> userProfile;
  List<Shoe> favoriteItems = [];
  List<Debitcardmodel> debitInfo = [];

  void submit(bool isEdit, [Debitcardmodel? obj]) {
    if (cardnoController.text.trim().isNotEmpty &&
        cvvController.text.trim().isNotEmpty &&
        expiryController.text.trim().isNotEmpty &&
        cardholdernameController.text.trim().isNotEmpty) {
      if (isEdit) {
//EDIT
        obj!.cardno = cardnoController.text;
        obj.cvv = cvvController.text;
        obj.expiry = expiryController.text;
        obj.cardholdername = cardholdernameController.text;
      } else {
//     ADD
        debitInfo.add(
          Debitcardmodel(
            cardno: cardnoController.text,
            cvv: cvvController.text,
            expiry: expiryController.text,
            cardholdername: cardholdernameController.text,
          ),
        );
      }
    }
    Navigator.of(context).pop();
    clearController();
    setState(() {});
  }

  //BOTTOM SHEET
  TextEditingController cardnoController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cardholdernameController = TextEditingController();

  void clearController() {
    cardholdernameController.clear();
    expiryController.clear();
    cvvController.clear();
    cardnoController.clear();
    setState(() {});
  }

  openBottomSheet(bool isEdit, [Debitcardmodel? debitInfo]) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isDismissible: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Add New Card",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color.fromRGBO(42, 62, 243, 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Card No",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color.fromRGBO(42, 62, 243, 1),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: cardnoController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                decoration: InputDecoration(
                  hintText: "xxxx xxxx xxxx xxxx",
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "CVV",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(42, 62, 243, 1),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          decoration: InputDecoration(
                            counterText: "", // Removes character count display
                            hintText: "*",
                            hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Expiry Date",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(42, 62, 243, 1),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: expiryController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Allow only digits
                            LengthLimitingTextInputFormatter(
                                5), // Limit to 5 characters (MM/YY)
                            ExpiryDateInputFormatter(), // Custom formatter for MM/YY
                          ],
                          decoration: InputDecoration(
                            hintText: "MM/YY",
                            hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Card Holder Name",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color.fromRGBO(42, 62, 243, 1),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: cardholdernameController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Enter full name",
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
                    minimumSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    if (isEdit == true) {
                      submit(true, debitInfo);
                    } else {
                      submit(false);
                    }
                  },
                  child: const Text(
                    "Add Card",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromRGBO(252, 251, 251, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  String? getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email; // Returns the user's email
    } else {
      throw Exception("User is not authenticated");
    }
  }

  @override
  void initState() {
    super.initState();

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

  bool isCardSelected = false;

  void selectDebitCard(bool isSelected) {
    setState(() {
      isCardSelected = isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.subtotal;
    final delivery = widget.delivery;
    final totalCost = subtotal + delivery;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            FutureBuilder<Map<String, dynamic>>(
                future: userProfile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text("No Profile Data Found"));
                  }

                  var profileData = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                               // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      "Contact Information",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: const Color.fromRGBO(
                                            26, 37, 48, 1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Image.asset("assets/images/call_icon.png"),
                                      Container(
                                        height: 35,
                                        width: 60,
                                        child: Image.network(
                                            "https://tse4.mm.bing.net/th?id=OIP.Yaficbwe3N2MjD2Sg0J9OgHaHa&pid=Api&P=0&h=180"),
                                      ),
                                      const SizedBox(width: 25),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Name",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  112, 123, 129, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${profileData['firstName'] ?? "No first name"} ${profileData['lastName'] ?? "No last name"}',
                                            //profileData[index].mobileNumber,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Color.fromRGBO(
                                                  26, 37, 48, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 35),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Image.asset("assets/images/call_icon.png"),
                                      SizedBox(
                                        height: 30,
                                        width: 60,
                                        child: Image.network(
                                            "https://tse1.mm.bing.net/th?id=OIP.uCEeUOoyzQMbDykSyBMicAHaHa&pid=Api&P=0&h=180"),
                                      ),
                                      const SizedBox(width: 23),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Email",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  112, 123, 129, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            getUserEmail() ?? '',
                                            //profileData[index].mobileNumber,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Color.fromRGBO(
                                                  26, 37, 48, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 35),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: Image.network(
                                              "https://tse2.mm.bing.net/th?id=OIP.3sgvZ5c2XtrG_wjbb9mpFQHaHa&pid=Api&P=0&h=180"),
                                        ),
                                      ),
                                      const SizedBox(width: 35),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Phone",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  112, 123, 129, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '+91 ${profileData['mobileNumber'] ?? "No number provided"}',
                                            //profileData[index].mobileNumber,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  26, 37, 48, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 35),
                                      // const Icon(Icons.edit_outlined),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14),
                                        child: Container(
                                          //  padding: const EdgeInsets.only(left: 9),
                                          height: 30,
                                          width: 30,
                                          child: Image.network(
                                            "https://tse3.mm.bing.net/th?id=OIP.DIpIX8fLalOCZzAXZaImLwHaHa&pid=Api&P=0&h=180",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 35),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Address",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  112, 123, 129, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            profileData['location'] ??
                                                "No location provided",
                                            //profileData[index].mobileNumber,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  26, 37, 48, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 35),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Payment Method",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color:
                                          const Color.fromRGBO(26, 37, 48, 1),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(
                                                "https://tse1.mm.bing.net/th?id=OIP.CK9P44mPPsVjZRi3BNEPBQHaEK&pid=Api&P=0&h=180"),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        const Text(
                                          "Debit Card",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(26, 37, 48, 1),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 205),
                                          child: GestureDetector(
                                            onTap: () {
                                              openBottomSheet(false);
                                              selectDebitCard(true);
                            
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.add_card_outlined,
                                              color:
                                                  Color.fromRGBO(7, 7, 7, 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  debitInfo.isNotEmpty &&
                                          index < debitInfo.length
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color.fromRGBO(
                                                234, 241, 245, 1),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Cardholder Name : ${debitInfo[index].cardholdername}",
                                                    style:
                                                        GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: const Color
                                                          .fromRGBO(
                                                          26, 37, 48, 1),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    "Card No : ${debitInfo[index].cardno}",
                                                    style:
                                                        GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: const Color
                                                          .fromRGBO(
                                                          26, 37, 48, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cardnoController.text =
                                                          debitInfo[index]
                                                              .cardno;
                                                      cardholdernameController
                                                              .text =
                                                          debitInfo[index]
                                                              .cardholdername;
                                                      cvvController.text =
                                                          debitInfo[index]
                                                              .cvv;
                                                      expiryController.text =
                                                          debitInfo[index]
                                                              .expiry;
                            
                                                      openBottomSheet(
                                                        true,
                                                        debitInfo[index],
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: Color.fromRGBO(
                                                          7, 7, 7, 1),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      debitInfo.remove(
                                                          debitInfo[index]);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Color.fromRGBO(
                                                          7, 7, 7, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            "No Card available",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  112, 123, 129, 1),
                                            ),
                                          ),
                                        ),
                                ]);
                          }),
                    ),
                  );
                }),

            const Spacer(),

            ///TOTAL COST
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Subtotal",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "₹$subtotal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Delivery",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "₹$delivery",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color.fromRGBO(43, 43, 43, 1),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Total Cost",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color.fromRGBO(43, 43, 43, 1),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "₹$totalCost",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color.fromRGBO(13, 110, 253, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                ///CHECKOUT BUTTON
                ElevatedButton(
                  onPressed: isCardSelected
                      ? () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: const Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.green),
                                    SizedBox(width: 8),
                                    Text('Payment Successful!'),
                                  ],
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(223, 239, 255, 1),
                                      ),
                                      child: Image.asset(
                                          "assets/images/payment_successful_icon.png"),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      "Your Payment Is Successful",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color.fromRGBO(43, 43, 43, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromRGBO(
                                            13, 110, 253, 1),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                    backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
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
            ),
          ],
        ),
      ),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Remove any non-digit or non-slash characters
    text = text.replaceAll(RegExp(r'[^\d/]'), '');

    if (text.length > 5) {
      // Enforce a maximum of 5 characters (MM/YY)
      text = text.substring(0, 5);
    }

    if (text.length >= 1) {
      // Ensure the first character is 0, 1, or 2
      int firstDigit = int.tryParse(text[0]) ?? 0;
      if (firstDigit > 1) {
        text = '0$text';
      }
    }

    if (text.length >= 2) {
      // Validate the month (01-12)
      int? month = int.tryParse(text.substring(0, 2));
      if (month == null || month < 1 || month > 12) {
        return oldValue; // Revert to the old value
      }
    }

    if (text.length == 2 && !text.contains('/')) {
      // Automatically append the slash after the month
      text += '/';
    }

    if (text.length > 2 && text[2] != '/') {
      // Force the slash to be at the third position
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }

    if (text.length > 5) {
      // Ensure the length does not exceed MM/YY
      text = text.substring(0, 5);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
