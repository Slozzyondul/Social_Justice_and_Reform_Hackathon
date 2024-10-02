import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Article Detail Screen
class ArticleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title'] ?? 'No Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('Source: ${article['source']['name']}'),
              const SizedBox(height: 10),
              Text(
                article['description'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              if (article['url'] != null)
                ElevatedButton(
                  onPressed: () {
                    _launchURL(article['url']);
                  },
                  child: const Text('Read Full Article'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to open the article URL in a browser
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
