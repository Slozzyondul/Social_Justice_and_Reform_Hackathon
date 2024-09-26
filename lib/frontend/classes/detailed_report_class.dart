import 'dart:io';

import 'package:flutter/material.dart';

class ReportDetailScreen extends StatelessWidget {
  final Map<String, dynamic> report;

  const ReportDetailScreen({super.key, required this.report});

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(report['title'] ?? 'Report Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report['title'] ?? 'No Title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Verified: ${report['verified'] ? "Yes" : "No"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (report['media'] != null)
              _isValidUrl(report['media'])
                  ? Image.network(
                      report['media'],
                      fit: BoxFit.cover,
                      height: 200, // Larger height for detail view
                    )
                  : Image.file(
                      File(report['media']),
                      fit: BoxFit.cover,
                      height: 200,
                    ),
            const SizedBox(height: 10),
            Text(
              'Description: ${report['description'] ?? ''}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Location: ${report['location'] ?? ''}'),
                Text('Status: ${report['status'] ?? ''}'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Submitted by User ID: ${report['user_id']}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
