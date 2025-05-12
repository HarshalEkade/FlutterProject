import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/Navigatorbar.dart';
import 'package:flutter_application_1/view/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Map<String, dynamic>> userProfile;
  List<Shoe> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize userProfile when the screen loads
    userProfile = fetchUserProfile();
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not authenticated");
    }
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

  void handlePopupMenuSelection(String value) {
    switch (value) {
      case 'Edit Profile':
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const EditProfile(),
          ),
        )
            .then((_) {
          // Refresh the user profile after returning from EditProfile
          setState(() {
            userProfile = fetchUserProfile();
          });
        });
        break;
      case 'Logout':
        FirebaseAuth.instance.signOut(); // Handle logout
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginScreen(
                    email: '',
                  )),
          (Route<dynamic> route) => false,
        );

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.raleway(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handlePopupMenuSelection,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Edit Profile',
                  child: Text('Edit Profile'),
                ),
                const PopupMenuItem(
                  value: 'Logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
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

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 105, top: 20, right: 100),
                child: Container(
                  height: 100,
                  width: 240,
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: profileData['profilePic'] != ''
                      ? Image.network(profileData['profilePic'],
                          fit: BoxFit.cover)
                      : const Icon(Icons.add_a_photo_rounded,
                          color: Colors.white, size: 35),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: GoogleFonts.raleway(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 390,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${profileData['firstName'] ?? "No first name"} ${profileData['lastName'] ?? "No last name"}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Location",
                          style: GoogleFonts.raleway(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Container(
                          height: 50,
                          width: 390,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[300]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              profileData['location'] ?? "No location provided",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          )),
                      const SizedBox(height: 10),
                      Text("Mobile No",
                          style: GoogleFonts.raleway(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      Container(
                          height: 50,
                          width: 390,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[300]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '+91 ${profileData['mobileNumber'] ?? "No number provided"}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          )),
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