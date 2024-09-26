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
      drawer: _mainDrawer(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStateColor.transparent),
                onPressed: () {
                  // Navigate to Fact Check Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsFactCheckScreen()));
                },
                child: const Text(
                  'Fact Check',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStateColor.transparent),
                onPressed: () {
                  // Navigate to Report Corruption Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReportCorruptionScreen()));
                },
                child: const Text(
                  'Report Corruption',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStateColor.transparent),
                onPressed: () {
                  // Navigate to Report Corruption Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewReportsScreen()));
                },
                child: const Text(
                  'View Corruption Reports',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Visitor'),
            accountEmail: Text('visitor@mail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(color: Colors.grey),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Fact Check'),
            onTap: () {
              Navigator.pushNamed(context, '/facts');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report'),
            onTap: () {
              Navigator.pushNamed(context, '/report');
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('Hot Now'),
            onTap: () {
              Navigator.pushNamed(context, '/viewreport');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Youth Empowerment'),
            onTap: () {
              Navigator.pushNamed(context, '/youths');
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Resources'),
            onTap: () {
              Navigator.pushNamed(context, '/resources');
            },
          ),
        ],
      ),
    );
  }
}
