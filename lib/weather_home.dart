import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Additional_Info.dart';
import 'package:weather_app/Hourly_Forecast.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  Future getCurrentWeather() async {
    try {
      String cityname = "LONDON";
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityname,uk&APPID=4870fea1b4e3a0a86306b5b7af704021',
        ),
      );
      final result = jsonDecode(res.body);

      if (result['cod'] != "200") {
        throw "An unexcpected error occured";
      }
      return result;

      // result['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          }

          final data = asyncSnapshot.data;
          final currentweather = data['list'][0];
          final currenttemp = currentweather['main']['temp'];
          final currentsky = currentweather['weather'][0]['main'];
          final currentpressure = currentweather['main']['pressure'];
          final currenthum = currentweather['main']['humidity'];
          final currentwind = currentweather['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "$currenttemp K",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              SizedBox(height: 16),
                              Icon(
                                currentsky == 'Clouds' || currentsky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "$currentsky",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hourly Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 11),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 1; i < 10; i++)
                //         HourlyForceast(
                //           time: (data['list'][i]['dt_txt']).substring(11, 16),
                //           icon:
                //               (data['list'][i]['weather'][0]['main'] ==
                //                       'Clouds' ||
                //                   data['list'][i]['weather'][0]['main'] ==
                //                       'Rain')
                //               ? Icons.cloud
                //               : Icons.sunny,
                //           temp: data['list'][i]['main']['temp'].toString(),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final hourly = data['list'][index + 1];
                      final time = DateTime.parse(hourly['dt_txt']);
                      return HourlyForceast(
                        time: DateFormat.j().format(time),
                        icon:
                            (hourly['weather'][0]['main'] == 'Clouds' ||
                                hourly['weather'][0]['main'] == 'Rain')
                            ? Icons.cloud
                            : Icons.sunny,
                        temp: hourly['main']['temp'].toString(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 11),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Additional_Info(
                      icon: Icons.water_drop_rounded,
                      title: "Humidity",
                      value: "$currenthum",
                    ),
                    Additional_Info(
                      icon: Icons.air,
                      title: "Wind Speed",
                      value: "$currentwind",
                    ),
                    Additional_Info(
                      icon: Icons.beach_access,
                      title: "Pressure",
                      value: "$currentpressure",
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
