import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight * 0.45,
              child:  Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}