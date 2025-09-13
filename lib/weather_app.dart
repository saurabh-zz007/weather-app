import 'dart:convert';
import 'dart:ui';
import 'package:weather_app/secret.dart';
import 'package:weather_app/weater_app_cards_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class weatherApp extends StatefulWidget {
  const weatherApp({super.key});

  @override
  State<weatherApp> createState() =>
      _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {
  Future<Map<String, dynamic>>
  getCurrentWeather() async {
    try {
      String cityName = 'Gorakhpur';
      final res = await http.get(
        Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$API',
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpecter error occured';
      }
      return data;
    } catch (e) {
      throw (e).toString();
    }
  }

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
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          final data = snapshot.data!;
          final currentTemp =
              data['list'][0]['main']['temp'];
          final currentSky =
              data['list'][0]['weather'][0]['main'];
          final currentHumidity =
              data['list'][0]['main']['humidity'];
          final currentPressure =
              data['list'][0]['main']['pressure'];
          final currentWindSpeed =
              data['list'][0]['wind']['speed'];
          return Padding(
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
                      borderRadius:
                          BorderRadius.all(
                            Radius.circular(15),
                          ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                            16,
                          ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(
                                8,
                              ),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Icon(
                                currentSky ==
                                        'Rain'
                                    ? Icons
                                          .cloudy_snowing
                                    : currentSky ==
                                          'Clouds'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                currentSky,
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
                SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        HourlyWeatherCard(
                          time: DateFormat.j()
                              .format(
                                DateTime.parse(
                                  data['list'][i +
                                      1]['dt_txt'],
                                ),
                              ),
                          iconWeather:
                              data['list'][i +
                                      1]['weather'][0]['main'] ==
                                  'Clouds'
                              ? Icons.cloud
                              : data['list'][i +
                                        1]['weather'][0]['main'] ==
                                    'Rain'
                              ? Icons
                                    .cloudy_snowing
                              : Icons.sunny,

                          temp:
                              data['list'][i +
                                      1]['main']['temp']
                                  .toString(),
                        ),
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
                      MainAxisAlignment
                          .spaceAround,

                  children: [
                    AdditionalInfoCard(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity
                          .toString(),
                    ),
                    AdditionalInfoCard(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed
                          .toString(),
                    ),
                    AdditionalInfoCard(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure
                          .toString(),
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
