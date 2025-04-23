import 'package:flutter/material.dart';
import 'package:radial_chart_package/radial_chart_package.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: RadialPerformanceChart(
            radius: 150,
            segments: [
              SegmentData(percentage: 72, color: Colors.blue, label: "72%"),
              SegmentData(percentage: 100, color: Colors.amber, label: "100%"),
              SegmentData(percentage: 65, color: Colors.red, label: "65%"),
            ],
          ),
        ),
      ),
    );
  }
}
