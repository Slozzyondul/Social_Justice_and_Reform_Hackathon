import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportCorruptionScreen extends StatefulWidget {
  const ReportCorruptionScreen({super.key});

  @override
  State<ReportCorruptionScreen> createState() => _ReportCorruptionScreenState();
}

class _ReportCorruptionScreenState extends State<ReportCorruptionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _verified = false;
  File? _imageFile;

  // Function to handle media upload
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void _submitReport() async {
    const String apiUrl = 'http://localhost:5000/submit-report';

    final Map<String, dynamic> reportData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'media': _imageFile?.path,
      'verified': _verified,
      'user_id': '1234', // Placeholder user ID
      'date_submitted': DateTime.now().toIso8601String(),
      'status': 'Pending', // add logic to display status message based on the approval from the board
      'email': _emailController.text,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reportData),
    );

    if (response.statusCode == 201) {
      // Report submitted successfully
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Report submitted successfully!'),
      ));
    } else {
      // Handle submission error
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to submit report'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Report Corruption')),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email (Optional)',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Verified:'),
                Switch(
                  value: _verified,
                  onChanged: (value) {
                    setState(() {
                      _verified = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Upload Media'),
                ),
                const SizedBox(width: 10),
                _imageFile != null ? const Text('Media selected') : Container(),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitReport,
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
