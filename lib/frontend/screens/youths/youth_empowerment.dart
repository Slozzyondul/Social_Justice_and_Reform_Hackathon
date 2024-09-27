import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class YouthEmpowerment extends StatelessWidget {
  final List<Map<String, String>> mentorshipPrograms = [
    {'title': 'Tech Mentorship', 'description': 'Learn coding with experts.', 'link': 'https://plpacademy.powerlearnproject.org/available-courses'},
    {'title': 'Business Mentorship', 'description': 'Entrepreneurship guidance.', 'link': 'https://ajiradigital.go.ke/#/index'},
  ];

  final List<Map<String, String>> leadershipPrograms = [
    {'title': 'Youth Leadership Summit', 'description': 'Develop leadership skills.', 'link': 'https://www.kenyaleadership.org/'},
    {'title': 'Community Leadership', 'description': 'Lead local projects.', 'link': 'https://kenya.dotrust.org/'},
  ];

  final List<Map<String, String>> volunteerPrograms = [
    {'title': 'Environmental Volunteering', 'description': 'Help protect the environment.', 'link': 'https://naturekenya.org/'},
    {'title': 'Teaching Volunteering', 'description': 'Teach kids in underprivileged areas.', 'link': 'https://www.agape-volunteers.com/programmes/teaching-volunteer-in-kenya'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Center(child: Text('Youth Empowerment')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children: programs.map((program) {
            return Card(
              child: ListTile(
                title: Text(program['title'] ?? ''),
                subtitle: Text(program['description'] ?? ''),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Open link in browser
                  _launchURL(program['link']);
                },
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _launchURL(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
