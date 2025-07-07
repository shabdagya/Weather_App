import 'package:flutter/material.dart';
import 'package:weather_app/weather_home.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WeatherHome(),
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}
