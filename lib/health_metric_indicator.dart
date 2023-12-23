
import 'package:flutter/material.dart';

class HealthMetricIndicator extends StatelessWidget {
  final double percentage;
  final Color color;
  final double topLeftRadius;
  final double bottomLeftRadius;
  final double topRightRadius;
  final double bottomRightRadius;

  const HealthMetricIndicator(
    this.percentage,
    this.color, {
    this.topLeftRadius = 0.0,
    this.bottomLeftRadius = 0.0,
    this.topRightRadius = 0.0,
    this.bottomRightRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          topRight: Radius.circular(topRightRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        ),
      ),
    );
  }
}

