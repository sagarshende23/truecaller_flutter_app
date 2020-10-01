import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC5161),
        centerTitle: true,
        title: Text(
          'HomePage',
        ),
      ),
      body: Center(
        child: Text(
          "HomePage",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
