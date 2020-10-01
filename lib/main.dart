import 'package:flutter/material.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';

import 'home_page.dart';
import 'verify_non_truecaller.dart';

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
    getTruecallerProfile();
  }

  Future getTruecallerProfile() async {
    truecaller.initializeSDK(
      sdkOptions: FlutterTruecallerScope.SDK_OPTION_WITH_OTP,
      footerType: FlutterTruecallerScope.FOOTER_TYPE_ANOTHER_METHOD,
      consentMode: FlutterTruecallerScope.CONSENT_MODE_POPUP,
      // consentTitleOptions: FlutterTruecallerScope.SDK_CONSENT_TITLE_VERIFY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC5161),
        centerTitle: true,
        title: Text(
          'Truecaller sample App',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Login Or Signup Using',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Color(0xFFEC5161),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () async {
                  await truecaller.getProfile();
                  FlutterTruecaller.manualVerificationRequired
                      .listen((required) {
                    if (required) {
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(builder: (_) => VerifyMobileNumber()));
                    } else {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => HomePage()));
                    }
                  });
                },
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Mobile Number'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_truecaller/flutter_truecaller.dart';

// import 'home_page.dart';
// import 'verify_non_truecaller.dart';

// void main() => runApp(
//       MaterialApp(
//         home: MyApp(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _result = '';
//   final FlutterTruecaller caller = FlutterTruecaller();

//   @override
//   void initState() {
//     super.initState();
//     getTrueCaller();
//   }

//   Future getTrueCaller() async {
//     await caller.initializeSDK(
//       sdkOptions: FlutterTruecallerScope.SDK_OPTION_WITH_OTP,
//       footerType: FlutterTruecallerScope.FOOTER_TYPE_ANOTHER_METHOD,
//       consentTitleOptions: FlutterTruecallerScope.SDK_CONSENT_TITLE_VERIFY,
//       consentMode: FlutterTruecallerScope.CONSENT_MODE_POPUP,
//       // sdkOptions: FlutterTruecallerScope.SDK_OPTION_WITH_OTP,
//       // footerType: FlutterTruecallerScope.FOOTER_TYPE_ANOTHER_METHOD,
//       // consentTitleOptions: FlutterTruecallerScope.SDK_CONSENT_TITLE_VERIFY,
//       // consentMode: FlutterTruecallerScope.CONSENT_MODE_POPUP,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Truecaller Plugin Example'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               // OutlineButton(
//               //   onPressed: () async {
//               //     bool isUsable = await caller.isUsable;
//               //     setState(() {
//               //       _result = isUsable ? "Usable" : "Not usable";
//               //     });
//               //   },
//               //   child: Text('Is usable?'),
//               // ),
//               Center(
//                   child: Text(
//                 "Login or Sign up Using",
//                 style: TextStyle(fontSize: 17),
//               )),
//               SizedBox(
//                 height: 20,
//               ),
//               RaisedButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//                 color: Color(0xFFEC5161),
//                 onPressed: () async {
//                   await caller.getProfile();
//                   FlutterTruecaller.manualVerificationRequired
//                       .listen((required) {
//                     if (required) {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (_) => Verify(),
//                         ),
//                       );
//                     } else {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (_) => HomePage(),
//                         ),
//                       );
//                     }
//                   });
//                 },
//                 child: Container(
//                   height: 50,
//                   child: Center(
//                     child: Text(
//                       'Mobile Number'.toUpperCase(),
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Text(_result ?? 'ERROR'),
//               // ),
//               // StreamBuilder<String>(
//               //   stream: FlutterTruecaller.callback,
//               //   builder: (context, snapshot) => Text(snapshot.data ?? ''),
//               // ),
//               // StreamBuilder<FlutterTruecallerException>(
//               //   stream: FlutterTruecaller.errors,
//               //   builder: (context, snapshot) =>
//               //       Text(snapshot.hasData ? snapshot.data.errorMessage : ''),
//               // ),
//               // StreamBuilder<TruecallerProfile>(
//               //   stream: FlutterTruecaller.trueProfile,
//               //   builder: (context, snapshot) =>
//               //       Text(snapshot.hasData ? snapshot.data.firstName : ''),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
