import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/session_data.dart';
import 'package:flutter_application_1/view/onboard2.dart';
import 'package:google_fonts/google_fonts.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 131, 194, 1),
      body: Column(
        children: [
          Center(
            child:
                Image.asset("assets/images/Screenshot 2024-11-10 115349.png"),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 100, right: 20, bottom:20),
        child: SizedBox(
          height: 50,
          width: 335,
          child: GestureDetector(
            onTap: ()async {
             // const Onboard2();
              //setState(() {});
               await SessionData.storeSessionData(
                        loginData: true,
                        email: "",
                      );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const Onboard2();
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(247, 238, 238, 236),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Get Started",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color.fromRGBO(43, 43, 43, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
