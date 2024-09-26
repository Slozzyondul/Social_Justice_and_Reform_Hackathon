import 'package:flutter/material.dart';
import 'package:solop/frontend/models/resources_model.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening links

class ResourceScreen extends StatelessWidget {
  final List<Resource> resources = [
    Resource(
      title: 'Civic Rights 101',
      description: 'Learn the basics of your civic rights and responsibilities.',
      category: 'Civic Rights',
      link: 'https://example.com/civic-rights',
    ),
    Resource(
      title: 'Constitutional Law Overview',
      description: 'Understand the legal frameworks in your country.',
      category: 'Legal Frameworks',
      link: 'https://example.com/legal-frameworks',
    ),
    Resource(
      title: 'Guide to Peaceful Activism',
      description: 'Explore peaceful activism strategies and methods.',
      category: 'Peaceful Activism',
      link: 'https://example.com/peaceful-activism',
    ),
    Resource(
      title: 'Legal Aid Resources',
      description: 'Find free or low-cost legal aid services.',
      category: 'Legal Frameworks',
      link: 'https://example.com/legal-aid',
    ),
    // Add more resources as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Resources'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: resources.map((resource) {
          return Card(
            child: ListTile(
              title: Text(resource.title),
              subtitle: Text(resource.description),
              trailing: Icon(Icons.link, color: Colors.blue),
              onTap: () {
                _openResource(resource.link);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  // Method to open links
  void _openResource(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
