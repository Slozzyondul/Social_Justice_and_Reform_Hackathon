import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyTrackingScreen extends StatelessWidget {
  // Sample data for promises, legislation, and reforms
  final List<Map<String, String>> promises = [
    {'title': 'Youth Employment Program', 'status': 'In Progress', 'link': 'https://example.com'},
    {'title': 'Affordable Housing', 'status': 'Completed', 'link': 'https://example.com'},
  ];

  final List<Map<String, String>> legislation = [
    {'title': 'Health Insurance Bill', 'status': 'Under Review', 'link': 'https://example.com'},
    {'title': 'Education Reform Act', 'status': 'Passed', 'link': 'https://example.com'},
  ];

  final List<Map<String, String>> reforms = [
    {'title': 'Judicial Reforms', 'status': 'Ongoing', 'link': 'https://example.com'},
    {'title': 'Economic Reforms', 'status': 'Pending', 'link': 'https://example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Center(child: Text('Policy Tracking')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildSection(context, 'Promises', promises),
          buildSection(context, 'Legislation', legislation),
          buildSection(context, 'Reforms', reforms),
        ],
      ),
    );
  }

  // Build a section for promises, legislation, and reforms
  Widget buildSection(BuildContext context, String sectionTitle, List<Map<String, String>> policies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children: policies.map((policy) {
            return Card(
              child: ListTile(
                title: Text(policy['title'] ?? ''),
                subtitle: Text('Status: ${policy['status']}'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  _launchURL(policy['link']);
                },
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Function to launch the URL in the browser
  void _launchURL(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
