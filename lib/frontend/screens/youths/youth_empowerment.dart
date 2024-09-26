import 'package:flutter/material.dart';

class YouthEmpowerment extends StatelessWidget {
  final List<Map<String, String>> mentorshipPrograms = [
    {'title': 'Tech Mentorship', 'description': 'Learn coding with experts.', 'link': 'https://example.com'},
    {'title': 'Business Mentorship', 'description': 'Entrepreneurship guidance.', 'link': 'https://example.com'},
  ];

  final List<Map<String, String>> leadershipPrograms = [
    {'title': 'Youth Leadership Summit', 'description': 'Develop leadership skills.', 'link': 'https://example.com'},
    {'title': 'Community Leadership', 'description': 'Lead local projects.', 'link': 'https://example.com'},
  ];

  final List<Map<String, String>> volunteerPrograms = [
    {'title': 'Environmental Volunteering', 'description': 'Help protect the environment.', 'link': 'https://example.com'},
    {'title': 'Teaching Volunteering', 'description': 'Teach kids in underprivileged areas.', 'link': 'https://example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youth Empowerment'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildSection(context, 'Mentorship Programs', mentorshipPrograms),
          buildSection(context, 'Leadership Programs', leadershipPrograms),
          buildSection(context, 'Volunteer Programs', volunteerPrograms),
        ],
      ),
    );
  }

  Widget buildSection(BuildContext context, String sectionTitle, List<Map<String, String>> programs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
          children: programs.map((program) {
            return Card(
              child: ListTile(
                title: Text(program['title'] ?? ''),
                subtitle: Text(program['description'] ?? ''),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Open link or detailed page
                  _launchURL(program['link']);
                },
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _launchURL(String? url) {
    if (url != null) {
      // Use a package like url_launcher to open URLs in the browser
      // url_launcher.launch(url);
    }
  }
}
