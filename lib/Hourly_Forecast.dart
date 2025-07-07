import 'package:flutter/material.dart';

class HourlyForceast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;

  const HourlyForceast({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Icon(icon, weight: 32),
            SizedBox(height: 8),
            Text(temp, style: TextStyle()),
          ],
        ),
      ),
    );
  }
}
