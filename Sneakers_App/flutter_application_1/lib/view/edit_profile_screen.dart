
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/view/customsnackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedFile;
  bool isProcessing = false; // Track if the process is ongoing
  // Upload image to Firebase Storage

  String? profileImageUrl; // Holds the profile image URL

  @override
  void initState() {
    super.initState();
    loadUserData(); // Load user data on initialization
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No authenticated user");
      return;
    }

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("profileInfo")
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          firstNameController.text = data['firstName'] ?? '';
          lastNameController.text = data['lastName'] ?? '';
          locationController.text = data['location'] ?? '';
          mobileNumberController.text = data['mobileNumber'] ?? '';
          profileImageUrl = data['profilePic']; // Fetch the profile image URL
        });
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<void> uploadImage({required String fileName}) async {
    if (_selectedFile == null) {
      print("No image selected");
      return;
    }

    print("Uploading image to Firebase");
    try {
      await FirebaseStorage.instance
          .ref()
          .child(fileName)
          .putFile(File(_selectedFile!.path));
      print("Image uploaded successfully");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  // Get image URL from Firebase Storage
  Future<String> downloadImageURL({required String fileName}) async {
    try {
      print("Getting URL for image from Firebase");
      String url =
          await FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
      print("Uploaded URL: $url");
      return url;
    } catch (e) {
      print("Error fetching URL: $e");
      return ''; // Return an empty string if there's an error
    }
  }

  // Add user data to Firestore
  void addDataToFirebase({required String url}) async {
    // Get the current authenticated user's UID
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User is not authenticated");
    }
    print("Uploading data to Firestore");
    Map<String, dynamic> data = {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'location': locationController.text,
      'mobileNumber': mobileNumberController.text,
      'profilePic': url,
    };

    await FirebaseFirestore.instance
        .collection("profileInfo")
        .doc(user.uid) // Using the UID as the document ID
        .set(data,
            SetOptions(merge: true)) // Merge to update without overwriting
        .then((_) {
      // Successfully updated data
      print("Profile updated successfully");
      // You can also clear the text fields here, or perform any other actions
    }).catchError((e) {
      print("Error uploading data to Firestore: $e");
    });
    CustomSnackbar.showCustomSnackbar(
      message: "Profile Updated",
      context: context,
    );
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
            backgroundColor: const Color.fromRGBO(13, 110, 253,1),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
            ),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.raleway(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white
            ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: isProcessing
                  ? null
                  : () async {
                      setState(() {
                        isProcessing = true;
                      });

                     
                       try {
                        String imageUrl = profileImageUrl ?? ''; 
                        if (_selectedFile != null) {
                          await uploadImage(
                              fileName: 'profile_pics/${_selectedFile!.name}');
                          imageUrl = await downloadImageURL(
                              fileName: 'profile_pics/${_selectedFile!.name}');
                        }
                        addDataToFirebase(url: imageUrl);

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Success"),
                              content:
                                  const Text("Profile Updated Successfully"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      } finally {
                        setState(() {
                          isProcessing = false;
                        });
                      }
                    },
              child: isProcessing
                  ? const CircularProgressIndicator()
                  : Text(
                      "Done",
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 105, top: 20, right: 100),
            child: GestureDetector(
              onTap: () async {
                _selectedFile =
                    await _imagePicker.pickImage(source: ImageSource.gallery);
                if (_selectedFile != null) {
                  print("File = ${_selectedFile!.path}");
                  setState(() {
                    profileImageUrl = null; // Reset URL to reflect selected file
                  });
                }
              },
              child: Container(
                height: 100,
                width: 240,
                
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                
                child: _selectedFile != null
                    ? Image.file(
                        File(_selectedFile!.path),
                        fit: BoxFit.fill,
                      )
                    : (profileImageUrl != null && profileImageUrl!.isNotEmpty
                        ? Image.network(
                            profileImageUrl!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.white,
                            size: 35,
                          )),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Change Profile Picture",
                style: GoogleFonts.raleway(
                    fontSize: 18,
                    color: const Color.fromRGBO(13, 110, 253, 1),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("First Name",
                      style: GoogleFonts.raleway(
                          fontSize: 18,
                          color: const Color.fromRGBO(43, 43, 43, 1),
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: firstNameController,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(43, 43, 43, 1)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Last Name",
                      style: GoogleFonts.raleway(
                          fontSize: 18,
                          color: const Color.fromRGBO(43, 43, 43, 1),
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(43, 43, 43, 1)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Location",
                      style: GoogleFonts.raleway(
                          fontSize: 18,
                          color: const Color.fromRGBO(43, 43, 43, 1),
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: locationController,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(43, 43, 43, 1)),
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Mobile Number",
                      style: GoogleFonts.raleway(
                          fontSize: 18,
                          color: const Color.fromRGBO(43, 43, 43, 1),
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(43, 43, 43, 1)
                      ),
                       inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                        
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
