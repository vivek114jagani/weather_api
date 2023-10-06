import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _temperature = '';
  String _country = '';

  Future<void> fetchWeatherData(String cityName) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=bab281d79e5f1e9755a68d754cc313e7&units=metric";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperature = data['main']['temp'];
      final country = data['sys']['country'];
      setState(() {
        _temperature = temperature.toString();
        _country = country.toString();
      });
    } else {
      // ignore: avoid_print
      print("Faild to fetch weather data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather API Calling"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Enter City Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String cityName = _cityController.text;
                fetchWeatherData(cityName);
              },
              child: const Text("Submit"),
            ),
            const SizedBox(height: 30),
            Text(
              'Temperature is $_temperature',
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              'Country is $_country',
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
