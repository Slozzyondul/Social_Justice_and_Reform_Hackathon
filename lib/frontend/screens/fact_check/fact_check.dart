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
          mainAxisAlignment: MainAxisAlignment.center,
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
                        child: GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of items per row
                            crossAxisSpacing:
                                10, // Horizontal space between grid items
                            mainAxisSpacing:
                                10, // Vertical space between grid items
                            childAspectRatio:
                                0.8, // Adjust the ratio to fit the content properly
                          ),
                          itemCount: _articles.length,
                          itemBuilder: (context, index) {
                            final article = _articles[index];
                            return Card(
                              color: Colors.grey,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onTap: () => _openArticleDetail(article),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    article['urlToImage'] != null
                                        ? Image.network(
                                            article['urlToImage'],
                                            fit: BoxFit.cover,
                                            height:
                                                120, // Adjust image height to fit well in the grid
                                            width: double.infinity,
                                          )
                                        : const SizedBox(), // Placeholder if no image URL
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        article['title'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines:
                                            2, // Ensure title fits within two lines
                                        overflow: TextOverflow
                                            .ellipsis, // Truncate text if it overflows
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        'Source: ${article['source']['name']}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    const Spacer(), // Pushes content to the bottom
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Author: ${article['author'] ?? 'Unknown'}',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            article['publishedAt'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
