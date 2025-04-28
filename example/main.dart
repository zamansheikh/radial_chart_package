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
            backgroundColor: Colors.black,
            centerCircleRadius: 0.30,
            gapPercentage: 0.005,
            segmentHeight: 1.5,
            radius: 150,
            segments: [
              SegmentData(percentage: 72, color: Colors.blue, label: "blue"),
              SegmentData(percentage: 100, color: Colors.amber, label: "amber"),
              SegmentData(percentage: 65, color: Colors.red, label: "red"),
              SegmentData(percentage: 50, color: Colors.green, label: "green"),
            ],
          ),
        ),
      ),
    );
  }
}
