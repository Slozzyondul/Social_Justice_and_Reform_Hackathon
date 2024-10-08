import 'package:flutter/material.dart';
import 'package:solop/frontend/models/resources_model.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening links

class ResourceScreen extends StatelessWidget {
  final List<Resource> resources = [
    Resource(
      title: 'Civic Rights 101',
      description: 'Learn the basics of your civic rights and responsibilities.',
      category: 'Civic Rights',
      link: 'https://info.mzalendo.com/info/citizens-rights#:~:text=Protection%20of%20right%20to%20property,water%2C%20social%20security%20%26%20education)',
    ),
    Resource(
      title: 'Constitutional Law Overview',
      description: 'Understand the legal frameworks in your country.',
      category: 'Legal Frameworks',
      link: 'https://www.klrc.go.ke/index.php/constitution-of-kenya',
    ),
    Resource(
      title: 'Guide to Peaceful Activism',
      description: 'Explore peaceful activism strategies and methods.',
      category: 'Peaceful Activism',
      link: 'https://www.rightofassembly.info/country/kenya',
    ),
    Resource(
      title: 'Legal Aid Resources',
      description: 'Find free or low-cost legal aid services.',
      category: 'Legal Frameworks',
      link: 'https://lsk.or.ke/public-resources/',
    ),
    // Add more resources as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Center(child: Text('Educational Resources')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: resources.map((resource) {
          return Card(
            child: ListTile(
              title: Text(resource.title),
              subtitle: Text(resource.description),
              trailing: const Icon(Icons.link, color: Colors.blue),
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
