
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackbar {
  static showCustomSnackbar({
    required String message,
    required BuildContext context,
    IconData? icon, 
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), 
        ),
        elevation: 10, 
        backgroundColor: const Color.fromRGBO(13, 110, 253,1), 
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.white, 
                size: 24, 
              ),
              const SizedBox(width: 10), 
            ],
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  color: Colors.white, 
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.yellowAccent, 
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
     ),
);
}
}