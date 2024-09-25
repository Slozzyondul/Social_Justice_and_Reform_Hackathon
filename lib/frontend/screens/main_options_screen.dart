import 'package:flutter/material.dart';
import 'package:solop/frontend/screens/fact_check/fact_check.dart';
import 'package:solop/frontend/screens/report/other_corruption_reports.dart';
import 'package:solop/frontend/screens/report/report_corruption_screen.dart';

class MainOptionScreen extends StatelessWidget {
  const MainOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Choose an Option')),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStateColor.transparent),
                onPressed: () {
                  // Navigate to Fact Check Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsFactCheckScreen()));
                },
                child: const Text('Fact Check', style: TextStyle(color: Colors.black),),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStateColor.transparent),
                onPressed: () {
                  // Navigate to Report Corruption Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReportCorruptionScreen()));
                },
                child: const Text('Report Corruption', style: TextStyle(color: Colors.black),),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStateColor.transparent),
                onPressed: () {
                  // Navigate to Report Corruption Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewReportsScreen()));
                },
                child: const Text('Veiw Corruption Reports', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
