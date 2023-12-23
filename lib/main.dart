import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: MyHealthBalanceWidget(),
        ),
      ),
    );
  }
}

class MyHealthBalanceWidget extends StatefulWidget {
  const MyHealthBalanceWidget({Key? key}) : super(key: key);

  @override
  _MyHealthBalanceWidgetState createState() => _MyHealthBalanceWidgetState();
}

class _MyHealthBalanceWidgetState extends State<MyHealthBalanceWidget>
    with SingleTickerProviderStateMixin {
  late String timeFrame;
  late List<double> metricPercentages;
  late List<double> animatedPercentages;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    timeFrame = 'Last Week';
    metricPercentages = [0.8, 0.1, 0.1];
    animatedPercentages = List.from(metricPercentages);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // Збільште тривалість анімації
    );
    _animation = Tween<double>(begin: 1, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _animation.addListener(() {
      setState(() {});
    });
  }

  void changeTimeFrame() {
    setState(() {
      if (timeFrame == 'Last Week') {
        timeFrame = 'Last Month';
        animatedPercentages = [0.59, 0.25, 0.16];
      } else {
        timeFrame = 'Last Week';
        animatedPercentages = [0.9, 0.07, 0.03];
      }

      double totalPercentage =
          animatedPercentages.reduce((value, element) => value + element);
      if (totalPercentage > 1.0) {
        animatedPercentages = animatedPercentages
            .map((percentage) => percentage / totalPercentage)
            .toList();
      }

      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Color(0xFF18181F),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Health balance',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text(
                          timeFrame,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: changeTimeFrame,
                          child: const Icon(
                            Icons.swap_horiz_sharp,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xFF23222F),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HealthMetricItem(
                                'Body',
                                (animatedPercentages[0] * 100).toInt(),
                                Color(0xFFAFC731)),
                            HealthMetricItem(
                                'Mind',
                                (animatedPercentages[1] * 100).toInt(),
                                Color(0xFF7343BF)),
                            HealthMetricItem(
                                'Spirit',
                                (animatedPercentages[2] * 100).toInt(),
                                Color(0xFF326AC3)),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          height: 20.0,
                          child:
                              HealthMetricIndicatorBar(animatedPercentages, _animation),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            changeTimeFrame();
                          },
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all<Size>(Size(1500, 30)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Color(0xFF767C86)),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(color: Colors.white),
                            ),
                            elevation:
                                MaterialStateProperty.all<double>(4),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Text(''),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

class HealthMetricItem extends StatelessWidget {
  final String title;
  final int percentage;
  final Color color;

  const HealthMetricItem(this.title, this.percentage, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(width: 8.0),
        Text(
          '$percentage%',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
