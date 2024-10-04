import 'package:flutter/material.dart';

Widget buildOptionButtonFacts(BuildContext context,
    {required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color}) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8.0,
    ),
    icon: Icon(icon, size: 28),
    label: Text(
      label,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    onPressed: onPressed,
  );
}
