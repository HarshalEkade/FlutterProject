import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/session_data.dart';
import 'package:flutter_application_1/view/HomePage.dart';
import 'onboard1.dart';

class Nike extends StatelessWidget {
  const Nike({super.key});

  void navigate(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        bool status = false;
        await SessionData.getSessionData();

        if (SessionData.isLogin!) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return Homepage(
                  email: SessionData.email!,
                );
              },
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const MyWidget();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 110, 253, 1),
      body: Center(
        child: Image.asset("assets/images/Screenshot 2024-11-10 115655.png"),
      ),
    );
  }
}
