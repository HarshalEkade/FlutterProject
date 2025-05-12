import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
// ignore: unused_import
import 'package:flutter_application_1/view/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBAqdq7EVUlVR63XzJh9Dt_GieabtBtL1Q",
        appId: "1:391580090069:android:8418619167796a68b62c5c",
        messagingSenderId: "391580090069",
        projectId: "sneekersapp-c3da8",
        storageBucket:  "sneekersapp-c3da8.firebasestorage.app",
        ), 
  );
  const MainApp app = MainApp();
  runApp(kDebugMode ? const MainApp() : app);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Nike(),
      debugShowCheckedModeBanner: false,
    );
  }
}




