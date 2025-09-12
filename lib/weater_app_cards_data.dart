import 'dart:ui';
import 'package:flutter/material.dart';

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        color: const Color.fromARGB(
          72,
          120,
          118,
          118,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: const Column(
              children: [
                Text(
                  '9:00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Icon(Icons.cloud, size: 32),
                SizedBox(height: 6),
                Text(
                  '300 F',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        children: [
          Icon(Icons.water_drop, size: 32),
          SizedBox(height: 10),
          Text(
            'Humidity',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '94',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
