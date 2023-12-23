
import 'package:flutter/material.dart';
import 'package:flutter_application_2/health_metric_indicator.dart';



class HealthMetricIndicatorBar extends StatefulWidget {
  final List<double> percentages;
  final Animation<double> animation;

  HealthMetricIndicatorBar(this.percentages, this.animation);

  @override
  _HealthMetricIndicatorBarState createState() =>
      _HealthMetricIndicatorBarState();
}

class _HealthMetricIndicatorBarState extends State<HealthMetricIndicatorBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: (widget.percentages[0] * 100 * widget.animation.value).toInt(),
          child: HealthMetricIndicator(
            widget.percentages[0],
           Color(0xFFAFC731),
            topLeftRadius: 10.0,
            bottomLeftRadius: 10.0,
            topRightRadius: 0.0,
            bottomRightRadius: 0.0,
          ),
        ),
        Expanded(
          flex: (widget.percentages[1] * 100 * widget.animation.value).toInt(),
          child: HealthMetricIndicator(
            widget.percentages[1],
            Color(0xFF7343BF),
            topLeftRadius: widget.percentages[0] > 0.0 ? 0.0 : 10.0,
            bottomLeftRadius: widget.percentages[0] > 0.0 ? 0.0 : 10.0,
            topRightRadius: widget.percentages[2] > 0.0 ? 0.0 : 10.0,
            bottomRightRadius: widget.percentages[2] > 0.0 ? 0.0 : 10.0,
          ),
        ),
        Expanded(
          flex: (widget.percentages[2] * 100 * widget.animation.value).toInt(),
          child: HealthMetricIndicator(
            widget.percentages[2],
             Color(0xFF326AC3),
            topLeftRadius: 0.0,
            bottomLeftRadius: 0.0,
            topRightRadius: 10.0,
            bottomRightRadius: 10.0,
          ),
        ),
      ],
    );
  }
}