import 'package:flutter/material.dart';

class Additional_Info extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const Additional_Info({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        SizedBox(height: 8),
        Text(title),
        SizedBox(height: 8),
        Text(value),
      ],
    );
  }
}
