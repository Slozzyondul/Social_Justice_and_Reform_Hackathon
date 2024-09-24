import 'package:flutter/material.dart';
import 'package:solop/frontend/screens/fact_check/fact_check.dart';
import 'package:solop/frontend/screens/report/other_corruption_reports.dart';
import 'package:solop/frontend/screens/report/report_corruption_screen.dart';

class MainOptionScreen extends StatelessWidget {
  const MainOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose an Option')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to Fact Check Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsFactCheckScreen()));
                },
                child: const Text('Proceed with Fact Check'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Report Corruption Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReportCorruptionScreen()));
                },
                child: const Text('Report Corruption'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Report Corruption Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewReportsScreen()));
                },
                child: const Text('Veiw Corruption Reports'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
