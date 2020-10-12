import 'package:flutter/material.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';
import 'package:truecaller_flutter_app/verify_mobile_number.dart';

import 'home_page.dart';

void main() => runApp(
      MaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterTruecaller truecaller = FlutterTruecaller();

  @override
  void initState() {
    super.initState();
    getTrueCaller();
  }

  Future getTrueCaller() async {
    await truecaller.initializeSDK(
      sdkOptions: FlutterTruecallerScope.SDK_OPTION_WITH_OTP,
      footerType: FlutterTruecallerScope.FOOTER_TYPE_ANOTHER_METHOD,
      consentMode: FlutterTruecallerScope.CONSENT_MODE_POPUP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC5161),
        centerTitle: true,
        title: Text("Truecaller Flutter App"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Text("Login Or Singup Using",
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: Color(0xFFEC5161),
                onPressed: () async {
                  await truecaller.getProfile();
                  FlutterTruecaller.manualVerificationRequired
                      .listen((isRequired) {
                    if (isRequired) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => VerifyMobileNumber()));
                    } else {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  });
                },
                child: Container(
                    height: 50,
                    child: Center(
                        child: Text('Mobile Number'.toUpperCase(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
