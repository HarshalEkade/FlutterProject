import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/session_data.dart';
import 'package:flutter_application_1/view/AdminLogin.dart';
import 'package:flutter_application_1/view/AdminPage.dart';
import 'package:flutter_application_1/view/HomePage.dart';
import 'package:flutter_application_1/view/forgot_password.dart';
import 'package:flutter_application_1/view/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import './customsnackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, email});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _showPassword = false;
  final Gradient gradient = const LinearGradient(
    colors: [
      Color.fromRGBO(87, 64, 236, 1), // Gold
      Color.fromRGBO(239, 243, 8, 1), // Orange
      Color.fromRGBO(139, 69, 19, 1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/Backgrounds/cloud.jpg'), // Path to your image
                fit: BoxFit.cover, // Makes the image cover the entire screen
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Blur intensity
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255)
                  .withOpacity(0.1), // Add a slight overlay
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                ShaderMask(
                  shaderCallback: (bounds) => gradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Center(
                    child: Text(
                      "नमस्ते!",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 34,
                        color: const Color.fromARGB(255, 223, 33, 33),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Log In to Walk in Style",
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: const Color.fromARGB(255, 8, 8, 8),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Email Address",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: const Color.fromRGBO(43, 43, 43, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _emailTextEditingController,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color.fromRGBO(0, 0, 0, 0.87), // Darker text
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600], // Slightly darker hint text
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Password",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: const Color.fromRGBO(43, 43, 43, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    
                    controller: _passwordtextEditingController,
                    obscureText: _showPassword,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color.fromRGBO(0, 0, 0, 0.87),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color.fromRGBO(0, 0, 0, 0.87),
                        ),
                      ),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ForgotPasswordScreen();
                        },
                      ));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: const Color.fromARGB(255, 5, 5, 5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_emailTextEditingController.text
                                .trim()
                                .isNotEmpty &&
                            _passwordtextEditingController.text
                                .trim()
                                .isNotEmpty) {
                          try {
                            UserCredential userCredential =
                                await _firebaseAuth.signInWithEmailAndPassword(
                              email: _emailTextEditingController.text,
                              password: _passwordtextEditingController.text,
                            );

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Homepage(
                                    email: userCredential.user!.email!,
                                  );
                                },
                              ),
                            );
                          } on FirebaseAuthException catch (error) {
                            CustomSnackbar.showCustomSnackbar(
                              message: error.code,
                              context: context,
                              icon: Icons.report_problem_outlined,
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(13, 110, 253,1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const AdminLoginScreen();
                          },
                        ));
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(13, 110, 253,1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Admin Login",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 44, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const Register();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register Now!",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: const Color.fromRGBO(0, 0, 0, 0.87),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   child: Image.asset("assets/Backgrounds/sonu.jpg"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
