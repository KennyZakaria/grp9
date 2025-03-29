import 'package:app/dashboard.dart';
import 'package:app/expenseDistribution.dart';
import 'package:app/home.dart';
import 'package:app/newExpenseScreen.dart';
import 'package:app/newTripScreen.dart';
import 'package:app/profile.dart';
import 'package:app/signin.dart';
import 'package:app/tripExpenseScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
      // home: MainScreen(),
    );
  }
}
