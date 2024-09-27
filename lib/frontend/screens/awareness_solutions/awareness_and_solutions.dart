import 'package:flutter/material.dart';

class AwarenessAndSolutionsScreen extends StatefulWidget {
  @override
  _AwarenessAndSolutionsScreenState createState() =>
      _AwarenessAndSolutionsScreenState();
}

class _AwarenessAndSolutionsScreenState
    extends State<AwarenessAndSolutionsScreen> {
  final TextEditingController _solutionController = TextEditingController();
  final List<Map<String, String>> suggestedSolutions = [];

  @override
  void dispose() {
    _solutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raise Awareness & Suggest Local Solutions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Awareness Section
            buildAwarenessSection(),
            const SizedBox(height: 20),

            // Solution Submission Section
            buildSolutionSubmissionSection(),
            const SizedBox(height: 20),

            // View Suggested Solutions Section
            buildSuggestedSolutionsSection(),
          ],
        ),
      ),
    );
  }

  // Awareness Section Widget
  Widget buildAwarenessSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Local Issues',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Problem: Lack of clean water in rural areas.',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 5),
        Text(
          'Description: Many rural areas are facing challenges in accessing clean water. The local government is seeking sustainable solutions from the community to address this issue.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Solution Submission Section Widget
  Widget buildSolutionSubmissionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Submit Your Local Solution',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _solutionController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Enter your solution',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_solutionController.text.isNotEmpty) {
              setState(() {
                suggestedSolutions.add({
                  'solution': _solutionController.text,
                });
                _solutionController.clear();
              });
            }
          },
          child: const Text('Submit Solution'),
        ),
      ],
    );
  }

  // Suggested Solutions Section Widget
  Widget buildSuggestedSolutionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggested Local Solutions',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: suggestedSolutions.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(suggestedSolutions[index]['solution'] ?? ''),
              ),
            );
          },
        ),
      ],
    );
  }
}
