import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/onboard3.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboard2 extends StatefulWidget {
  const Onboard2({super.key});

  @override
  State<Onboard2> createState() => _Onboard2State();
}

class _Onboard2State extends State<Onboard2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 131, 194, 1),
      body: Column(
        children: [
          Center(
            child:
                Image.asset("assets/images/Screenshot 2024-11-10 115425.png"),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 300, right: 20, bottom:20),
        child: SizedBox(
          height: 50,
          width: 335,
          child: GestureDetector(
            onTap: () {
            //  const Onboard3();
              //setState(() {});

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const Onboard3();
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
                  "Next",
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
