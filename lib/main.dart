import 'package:flutter/material.dart';
import 'package:solop/frontend/screens/awareness_solutions/awareness_and_solutions.dart';
import 'package:solop/frontend/screens/fact_check/fact_check.dart';
import 'package:solop/frontend/screens/policies/policy_tracking_screen.dart';
import 'package:solop/frontend/screens/report/other_corruption_reports.dart';
import 'package:solop/frontend/screens/report/report_corruption_screen.dart';
import 'package:solop/frontend/screens/resources/material_resource.dart';
import 'package:solop/frontend/screens/splash_screen_wrapper.dart';
import 'package:solop/frontend/screens/youths/youth_empowerment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zii kwa Corruption',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      //home: const SplashScreenWrapper(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreenWrapper(),
        '/facts': (context) => const NewsFactCheckScreen(),
        '/report': (context) => const ReportCorruptionScreen(),
        '/viewreport': (context) => const ViewReportsScreen(),
        '/youths': (context) =>  YouthEmpowerment(),
        '/resources': (context) =>  ResourceScreen(),
        '/policies': (context) => PolicyTrackingScreen(),
        "/awareness": (context) => AwarenessAndSolutionsScreen(),
      },
    );
  }
}

