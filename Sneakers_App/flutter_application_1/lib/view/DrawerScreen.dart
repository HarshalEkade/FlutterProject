import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/FavouriteScreen.dart';
import 'package:flutter_application_1/view/Orders.dart';
import 'package:flutter_application_1/view/edit_profile_screen.dart';
import 'package:flutter_application_1/view/login_screen.dart';
import 'package:flutter_application_1/view/my_cart.dart';
import 'package:flutter_application_1/view/notifications.dart';
import 'package:flutter_application_1/view/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart'; // Adjust import according to your project

Future<Map<String, dynamic>> getUserProfile() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception("User not authenticated");
  }

  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('profileInfo')
      .doc(user.uid) // Using UID to get the profile document
      .get();

  if (doc.exists) {
    return doc.data() as Map<String, dynamic>;
  } else {
    throw Exception("Profile data not found");
  }
}

class MyDrawer extends StatelessWidget {
  final List<Shoe> favoriteItems =
      []; // Initialize your favoriteItems list or use from parent class if required

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
      child: FutureBuilder<Map<String, dynamic>>(
        future: getUserProfile(), // Fetch user profile data asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No profile data found"));
          }

          // Get the profile data from Firestore
          var profileData = snapshot.data!;

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    // Display the user's profile picture (or a default icon if none)
                    Container(
                      height: 90,
                      width: 100,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: (profileData['profilePic'] != null &&
                              Uri.tryParse(profileData['profilePic'])
                                      ?.hasAbsolutePath ==
                                  true)
                          ? Image.network(
                              profileData['profilePic'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.account_circle,
                                    size: 60);
                              }, // Handle network errors gracefully
                            )
                          : const Icon(Icons.account_circle,
                              size: 60), // Default icon if no picture
                    ),
                    const SizedBox(height: 10),
                    // Display the user's name (first and last name)
                    Text(
                      "${profileData['firstName']} ${profileData['lastName']}",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Image.asset("assets/images/profile_icon.png"),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: ListTile(
                  leading: Image.asset("assets/images/my_cart_icon.png"),
                  title: const Text(
                    "My Cart",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FavoritesScreen(favoriteItems: favoriteItems);
                      },
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.asset("assets/images/favourites_icon.png"),
                  title: const Text(
                    "Favorites",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Image.asset("assets/images/orders_icon.png"),
                title: const Text(
                  "Orders",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const MyOrders();
                      },
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Image.asset("assets/images/notifications_icon.png"),
                  title: const Text(
                    "Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const Notifications();
                      }),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const EditProfile();
                      },
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.asset("assets/images/settings_icon.png"),
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Image.asset("assets/images/signout_icon.png"),
                title: GestureDetector(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen(
                                  email: '',
                                )),
                        (Route<dynamic> route) => false,
                      );
                    } catch (e) {
                      log('Error signing out: $e');
                    }
                  },
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
