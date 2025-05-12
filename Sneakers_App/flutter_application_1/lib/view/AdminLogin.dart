import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/AdminPage.dart';
import 'package:flutter_application_1/view/customsnackbar.dart';
import 'package:flutter_application_1/view/forgot_password.dart';
import 'package:flutter_application_1/view/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _showPassword = false;

  final Gradient gradient = const LinearGradient(
    colors: [
      Color.fromRGBO(87, 64, 236, 1), 
      Color.fromRGBO(239, 243, 8, 1), 
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
                image: AssetImage('assets/Backgrounds/cloud.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: const Color.fromARGB(255, 147, 143, 143).withOpacity(0.3),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Color.fromRGBO(7, 7, 7, 1),
                        ),
                      ),
                      const SizedBox(width: 110),
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Log In to Walk in Style",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Email Address",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: const Color.fromARGB(255, 10, 10, 10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailTextEditingController,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      hintStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[700]),
                      prefixIcon:
                          const Icon(Icons.email, ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Password",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: const Color.fromARGB(255, 10, 10, 10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordTextEditingController,
                    obscureText: !_showPassword,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
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
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey[700],
                        ),
                      ),
                      hintText: "Enter your password",
                      hintStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[700]),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: const Color.fromARGB(255, 10, 10, 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_emailTextEditingController.text.isNotEmpty &&
                            _passwordTextEditingController.text.isNotEmpty) {
                          try {
                            UserCredential userCredential =
                                await _firebaseAuth.signInWithEmailAndPassword(
                              email: _emailTextEditingController.text.trim(),
                              password:
                                  _passwordTextEditingController.text.trim(),
                            );

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AdminScreen(
                                  email: userCredential.user!.email!,
                                ),
                              ),
                            );
                          } on FirebaseAuthException catch (error) {
                            CustomSnackbar.showCustomSnackbar(
                              message: error.code,
                              context: context,
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
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: Text(
                        "Don't have an account? Register Now!",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color.fromARGB(255, 10, 10, 10),
                        ),
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