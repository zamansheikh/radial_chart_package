import 'dart:math';
import 'package:flutter/material.dart';
import 'segment_data.dart';

class RadialPerformanceChart extends StatefulWidget {
  final double radius;
  final List<SegmentData> segments;
  final double centerCircleRadius;
  final double gapPercentage;
  final double segmentHeight;
  final Color backgroundColor;

  const RadialPerformanceChart({
    super.key,
    required this.radius,
    required this.segments,
    this.centerCircleRadius = 0.25,
    this.gapPercentage = 0.005,
    this.segmentHeight = 1.5,
    this.backgroundColor = const Color.fromARGB(57, 23, 104, 159),
  });

  @override
  State<RadialPerformanceChart> createState() => _RadialPerformanceChartState();
}

class _RadialPerformanceChartState extends State<RadialPerformanceChart>
    with SingleTickerProviderStateMixin {
  int? selectedIndex;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  void onSegmentTap(int index) {
    if (selectedIndex == index) {
      _controller.reverse().then((_) {
        setState(() => selectedIndex = null);
      });
    } else {
      setState(() => selectedIndex = index);
      _controller.forward(from: 0);
    }
  }

  int? _detectTouchedSegment(Offset position) {
    final center = Offset(widget.radius, widget.radius);

    double angle = atan2(position.dy - center.dy, position.dx - center.dx);
    angle = (angle + 2 * pi) % (2 * pi);
    angle = (angle - (-pi / 2) + 2 * pi) % (2 * pi);

    final segmentAngle = 2 * pi / widget.segments.length;
    final index = (angle / segmentAngle).floor();

    return index < widget.segments.length ? index : null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: GestureDetector(
          onTapUp: (details) {
            final index = _detectTouchedSegment(details.localPosition);
            if (index != null) onSegmentTap(index);
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder:
                (_, __) => CustomPaint(
                  painter: _RadialChartPainter(
                    segments: widget.segments,
                    centerCircleRadius: widget.centerCircleRadius,
                    gapPercentage: widget.gapPercentage,
                    segmentHeight: widget.segmentHeight,
                    animationValue: _controller.value,
                    selectedIndex: selectedIndex,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _RadialChartPainter extends CustomPainter {
  final List<SegmentData> segments;
  final double centerCircleRadius;
  final double gapPercentage;
  final double segmentHeight;
  final double animationValue;
  final int? selectedIndex;

  _RadialChartPainter({
    required this.segments,
    required this.centerCircleRadius,
    required this.gapPercentage,
    required this.segmentHeight,
    required this.animationValue,
    required this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final baseRadius = size.shortestSide / segmentHeight;
    final segmentAngle = 2 * pi / segments.length;
    final gapAngle = 2 * pi * gapPercentage;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final isSelected = i == selectedIndex;

      final startAngle = -pi / 2 + (segmentAngle * i) + gapAngle / 2;
      final sweepAngle = segmentAngle - gapAngle;

      final innerRadius = baseRadius * centerCircleRadius;
      double thickness = (segment.percentage / 100) * baseRadius * 0.5;
      if (isSelected) thickness *= (1 + 0.2 * animationValue);

      double outerRadius = innerRadius + thickness;
      final maxAllowed = baseRadius - 8;
      if (outerRadius > maxAllowed) {
        outerRadius = maxAllowed;
        thickness = outerRadius - innerRadius;
      }

      final radius = (innerRadius + outerRadius) / 2;
      final rect = Rect.fromCircle(center: center, radius: radius);

      final paint =
          Paint()
            ..color = segment.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = thickness
            ..strokeCap = StrokeCap.butt;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

      if (isSelected && segment.label != null) {
        final labelAngle = startAngle + sweepAngle / 2;
        final labelRadius = outerRadius + 16;
        final offset = Offset(
          center.dx + cos(labelAngle) * labelRadius,
          center.dy + sin(labelAngle) * labelRadius,
        );

        textPainter.text = TextSpan(
          text: segment.label!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          offset - Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
