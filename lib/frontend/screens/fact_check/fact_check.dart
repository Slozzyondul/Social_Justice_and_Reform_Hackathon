import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsFactCheckScreen extends StatefulWidget {
  const NewsFactCheckScreen({super.key});

  @override
  _NewsFactCheckScreenState createState() => _NewsFactCheckScreenState();
}

class _NewsFactCheckScreenState extends State<NewsFactCheckScreen> {
  final TextEditingController _inputController = TextEditingController();
  String? _factCheckResult;
  bool _loading = false;

  // Function to call the News API for fact-checking
  Future<void> factCheck(String query) async {
    setState(() {
      _loading = true;
      _factCheckResult = null;
    });

    // Replace with your News API key and endpoint
    const String apiKey = 'df463b7e58c84096b6755ea188e5267f';
    final String apiUrl =
        'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey&language=en';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _factCheckResult = parseNewsFactCheckResult(data);
        });
      } else {
        setState(() {
          _factCheckResult =
              'Failed to retrieve fact-check data. Error code: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        _factCheckResult = 'An error occurred: $error';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  // Function to parse the API response
  String parseNewsFactCheckResult(Map<String, dynamic> data) {
    if (data['articles'] != null && data['articles'].isNotEmpty) {
      var articlesList = data['articles']
          .map((article) => 'Title: ${article['title']}\n'
              'Source: ${article['source']['name']}\n'
              'Description: ${article['description'] ?? "No description"}\n')
          .join('\n\n');

      return articlesList;
    } else {
      return 'No fact-check information found for this query.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fact Check')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                  labelText: 'Enter claim to fact-check',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_inputController.text.isNotEmpty) {
                  factCheck(_inputController.text);
                }
              },
              child: const Text('Check Fact'),
            ),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : _factCheckResult != null
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            _factCheckResult!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
