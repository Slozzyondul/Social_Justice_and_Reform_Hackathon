import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solop/frontend/classes/detailed_article_class.dart';
import 'dart:convert';

class NewsFactCheckScreen extends StatefulWidget {
  const NewsFactCheckScreen({super.key});

  @override
  _NewsFactCheckScreenState createState() => _NewsFactCheckScreenState();
}

class _NewsFactCheckScreenState extends State<NewsFactCheckScreen> {
  final TextEditingController _inputController = TextEditingController();
  List<dynamic> _articles = [];
  bool _loading = false;

  // Function to call the News API for fact-checking
  Future<void> factCheck(String query) async {
    setState(() {
      _loading = true;
      _articles = [];
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
          _articles = data['articles'];
        });
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error fetching data: ${response.statusCode}'),
          ));
        });
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred: $error'),
        ));
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  // Function to navigate to the detailed article screen
  void _openArticleDetail(Map<String, dynamic> article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Fact Check')),
        backgroundColor: Colors.grey,
      ),
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
              style: const ButtonStyle(
                  backgroundColor: WidgetStateColor.transparent),
              onPressed: () {
                if (_inputController.text.isNotEmpty) {
                  factCheck(_inputController.text);
                }
              },
              child: const Text(
                'Verify Fact',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : _articles.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _articles.length,
                          itemBuilder: (context, index) {
                            final article = _articles[index];
                            return Card(
                              color: Colors.grey,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                
                                leading: Image.network(article['urlToImage']),
                                trailing: Text(article['publishedAt']),
                                title: Text(
                                  article['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Source: ${article['source']['name']}',
                                ),
                                onTap: () => _openArticleDetail(article),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text('No articles found.'),
          ],
        ),
      ),
    );
  }
}
