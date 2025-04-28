import 'package:flutter/material.dart';

/// Represents data for a single segment in a radial performance chart.
class SegmentData {
  /// The percentage value of the segment, determining its thickness.
  final double percentage;

  /// The color of the segment.
  final Color color;

  /// An optional label to display when the segment is selected.
  final String? label;

  /// Creates a [SegmentData] instance with the specified properties.
  SegmentData({required this.percentage, required this.color, this.label});
}
