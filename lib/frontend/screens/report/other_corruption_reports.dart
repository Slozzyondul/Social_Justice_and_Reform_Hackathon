import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solop/frontend/classes/comments_section.dart';
import 'package:solop/frontend/classes/detailed_report_class.dart';
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
        backgroundColor: Colors.blueGrey,
        title: const Center(child: Text('Corruption Reports')),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 350).floor(),
                crossAxisSpacing: 16, // Space between columns
                mainAxisSpacing: 16, // Space between rows
                childAspectRatio: 0.75, // Aspect ratio for proper layout
              ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Card(
                  elevation: 8, // Adds shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
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
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                report['verified'] ? "✔️ Verified" : "❌ Not Verified",
                                style: TextStyle(
                                  color: report['verified'] ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (report['media'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: _isValidUrl(report['media'])
                                    ? Image.network(
                                        report['media'],
                                        fit: BoxFit.cover,
                                        height: 120,
                                      )
                                    : Image.file(
                                        File(report['media']),
                                        fit: BoxFit.cover,
                                        height: 120,
                                      ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            'Description: ${report['description'] ?? ''}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location: ${report['location'] ?? ''}',
                                style: const TextStyle(color: Colors.blueAccent),
                              ),
                              Text(
                                'Status: ${report['status'] ?? ''}',
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.thumb_up),
                                    color: Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        report['upvotes'] =
                                            (report['upvotes'] ?? 0) + 1;
                                      });
                                    },
                                  ),
                                  Text(report['upvotes']?.toString() ?? '0'),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.thumb_down),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        report['downvotes'] =
                                            (report['downvotes'] ?? 0) + 1;
                                      });
                                    },
                                  ),
                                  Text(report['downvotes']?.toString() ?? '0'),
                                  TextButton.icon(
                                    icon: const Icon(Icons.comment),
                                    label: const Text('Comments'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CommentsScreen(
                                              reportId: report['id'] ?? 0),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
