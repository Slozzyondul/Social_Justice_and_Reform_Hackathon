import 'package:flutter/material.dart';
import 'package:solop/frontend/screens/fact_check/fact_check.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zii kwa Corruption',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: NewsFactCheckScreen(),
    );
  }
}

