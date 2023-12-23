import 'package:flutter/material.dart';
import 'package:flutter_application_2/health_balance_widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: MyHealthBalanceWidget(),
        ),
      ),
    );
  }
}
