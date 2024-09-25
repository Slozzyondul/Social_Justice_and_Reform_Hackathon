import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ViewReportsScreen extends StatefulWidget {
  const ViewReportsScreen({super.key});

  @override
  State<ViewReportsScreen> createState() => _ViewReportsScreenState();
}

class _ViewReportsScreenState extends State<ViewReportsScreen> {
  List<dynamic> reports = [];
  bool isLoading = true;

  bool _isValidUrl(String url) {
    return url.startsWith('http') || url.startsWith('https');
  }

  // Function to fetch reports from the backend
  Future<void> fetchReports() async {
    const String apiUrl = 'http://localhost:5000/reports'; // Flask server URL

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          reports = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to load reports'),
        ));
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error fetching reports'),
      ));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Corruption Reports'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report['title'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text('Description: ${report['description'] ?? ''}'),
                        const SizedBox(height: 10),
                        Text('Location: ${report['location'] ?? ''}'),
                        const SizedBox(height: 10),
                        Text('Verified: ${report['verified'] ? "Yes" : "No"}'),
                        const SizedBox(height: 10),
                        Text('Status: ${report['status'] ?? ''}'),
                        if (report['media'] != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text('Media:'),
                              _isValidUrl(report['media'])
                                  ? Image.network(report['media'])
                                  : Image.file(File(report['media'])),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
