import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/reset_password.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  OtpVerificationScreen({required this.email});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isOtpVerified = false;

  void verifyOtp(String enteredOtp) {
    // Replace with your custom OTP logic
    const generatedOtp = "9370"; // Example OTP for testing
    if (enteredOtp == generatedOtp) {
      setState(() {
        isOtpVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP verified successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("OTP sent to ${widget.email}"),
            SizedBox(height: 16),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                verifyOtp(otpController.text.trim());
              },
              child: Text("Verify OTP"),
            ),
            if (isOtpVerified)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen(email: widget.email),
                    ),
                  );
                },
                child: Text("Proceed to Reset Password"),
              ),
          ],
        ),
      ),
    );
  }
}
