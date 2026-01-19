import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const CardTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(0.5),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
