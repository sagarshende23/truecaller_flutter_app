import 'package:flutter/material.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';

import 'home_page.dart';

class VerifyMobileNumber extends StatefulWidget {
  @override
  _VerifyMobileNumberState createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  final TextEditingController _mobile = TextEditingController();

  final TextEditingController _firstName = TextEditingController();

  final TextEditingController _lastName = TextEditingController();

  final TextEditingController _otp = TextEditingController();

  final FlutterTruecaller truecaller = FlutterTruecaller();

  bool otpRequired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(
                controller: _mobile,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Enter Mobile Number'),
              ),
            ),
            OutlineButton(
                onPressed: () async {
                  otpRequired =
                      await truecaller.requestVerification(_mobile.text);
                },
                child: Text('Verify')),
            if (otpRequired)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _otp,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: 'Enter otp'),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _firstName,
                decoration: InputDecoration(hintText: 'Enter  First Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _lastName,
                decoration: InputDecoration(hintText: 'Enter last Name'),
              ),
            ),
            OutlineButton(
                onPressed: () async {
                  if (otpRequired) {
                    await truecaller.verifyOtp(
                        _firstName.text, _lastName.text, _otp.text);
                  } else {
                    Future.delayed(Duration(seconds: 3));
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text('Submit')),

            //Developer Point of View TO understand the Truecaller SDK
            StreamBuilder<String>(
              stream: FlutterTruecaller.callback,
              builder: (context, snasphot) => Text(snasphot.data ?? " "),
            ),
            StreamBuilder<FlutterTruecallerException>(
              stream: FlutterTruecaller.errors,
              builder: (context, snasphot) =>
                  Text(snasphot.hasData ? snasphot.data.errorMessage : " "),
            ),

            StreamBuilder<TruecallerProfile>(
              stream: FlutterTruecaller.trueProfile,
              builder: (context, snasphot) => Text(snasphot.hasData
                  ? snasphot.data.firstName + " " + snasphot.data.lastName
                  : " "),
            ),
          ],
        ),
      ),
    );
  }
}
