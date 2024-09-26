import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:solop/frontend/classes/detailed_report_class.dart';

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
        backgroundColor: Colors.grey,
        title: const Text('View Corruption Reports'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 300).floor(),
                crossAxisSpacing: 10, // Space between columns
                mainAxisSpacing: 10, // Space between rows
                childAspectRatio: 0.75, // Aspect ratio to avoid overflow
              ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Card(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReportDetailScreen(report: report),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  report['title'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                  'Verified: ${report['verified'] ? "Yes" : "No"}'),
                            ],
                          ),
                          if (report['media'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: _isValidUrl(report['media'])
                                  ? Image.network(
                                      report['media'],
                                      fit: BoxFit.cover,
                                      height:
                                          150, // Set a fixed height to avoid overflow
                                    )
                                  : Image.file(
                                      File(report['media']),
                                      fit: BoxFit.cover,
                                      height: 150,
                                    ),
                            ),
                          const SizedBox(height: 10),
                          Text(
                            'Description: ${report['description'] ?? ''}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Location: ${report['location'] ?? ''}'),
                              const Spacer(),
                              Text('Status: ${report['status'] ?? ''}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
