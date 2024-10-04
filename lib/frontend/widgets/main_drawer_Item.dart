
import 'package:flutter/material.dart';

Widget buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurpleAccent),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }