import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solop/frontend/classes/detailed_article_class.dart';
import 'dart:convert';

import 'package:solop/frontend/widgets/fact_build_button_widget.dart';

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
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: Text(
                  'Enter a keyword you would like to fact-check',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _inputController,
                decoration: const InputDecoration(
                  labelText: 'Enter claim to fact-check',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildOptionButtonFacts(
                context,
                icon: Icons.search,
                label: 'Fact check',
                onPressed: () => factCheck(_inputController.text),
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(height: 24),
              _loading
                  ? const CircularProgressIndicator()
                  : _articles.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (MediaQuery.of(context).size.width / 300)
                                      .floor(),
                              crossAxisSpacing:
                                  5, // Horizontal space between grid items
                              mainAxisSpacing:
                                  5, // Vertical space between grid items
                              childAspectRatio:
                                  1, // Adjust the ratio to fit the content properly
                            ),
                            itemCount: _articles.length,
                            itemBuilder: (context, index) {
                              final article = _articles[index];
                              return Card(
                                color: Colors.grey,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () => _openArticleDetail(article),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                      : const Text(
                          'No articles found.',
                          style: TextStyle(color: Colors.white70),
                        ),
            ],
          ),
        ],
      ),
    );
  }
}
