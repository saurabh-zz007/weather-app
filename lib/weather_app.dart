import 'dart:ui';
import 'package:weather_app/weater_app_cards_data.dart';
import 'package:flutter/material.dart';

class weatherApp extends StatefulWidget {
  const weatherApp({super.key});

  @override
  State<weatherApp> createState() =>
      _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('pressed');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,

              child: Card(
                elevation: 10.0,
                color: const Color.fromARGB(
                  72,
                  120,
                  118,
                  118,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            '300 F',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Rain',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Weather Forecast',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                ],
              ),
            ),

            //forecast cards
            SizedBox(height: 10),
            const Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            //Additional info
            SizedBox(height: 15),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,

              children: [
                AdditionalInfoCard(),
                AdditionalInfoCard(),
                AdditionalInfoCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
