import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/Homepage.dart';

class Spalsh extends StatefulWidget {
  const Spalsh({super.key});

  @override
  State<Spalsh> createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Lottie.asset("assets/todologo.json"))],
      ),
    );
  }
}
