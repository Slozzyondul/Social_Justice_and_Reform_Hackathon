import 'package:flutter/material.dart';
import 'package:solop/frontend/screens/fact_check/fact_check.dart';
import 'package:solop/frontend/screens/splash_screen.dart';

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  bool _isLoading = true;
 
  @override
  void initState() {
    super.initState();
    _loadData(); // Simulating data loading
  }

  Future<void> _loadData() async {
    // Simulate some loading time
    await Future.delayed(const Duration(seconds: 5));

    // After loading data, update the state to switch to the HomeScreen
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const SplashScreen() : const NewsFactCheckScreen();
  }
}