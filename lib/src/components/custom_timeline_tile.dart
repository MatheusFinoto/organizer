import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class CustomTimeLine extends StatelessWidget {
  const CustomTimeLine(
      {super.key,
      required this.processIndex,
      required this.doneProcess,
      required this.width,
      required this.processLen});

  final int processIndex;
  final bool doneProcess;
  final double width;
  final int processLen;

  final Color completeColor = const Color(0xff5e6172);
  final Color inProgressColor = const Color(0xff5ec792);
  final Color todoColor = const Color(0xffd1d2d7);

  Color getColor(int index) {
    if (index == processIndex) {
      return inProgressColor;
    } else if (index < processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          connectorTheme: const ConnectorThemeData(
            space: 30.0,
            thickness: 5.0,
          ),
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: processLen,
          itemExtentBuilder: (_, __) => width / processLen,
          indicatorBuilder: (_, index) {
            Color color;
            Widget? child;

            if (index == processIndex) {
              if (doneProcess) {
                color = completeColor;
                child = const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15.0,
                );
              } else {
                color = inProgressColor;
                child = const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            } else if (index < processIndex) {
              color = completeColor;
              child = const Icon(
                Icons.check,
                color: Colors.white,
                size: 15.0,
              );
            } else {
              color = todoColor;
            }

            if (index <= processIndex) {
              return Stack(
                children: [
                  CustomPaint(
                    size: const Size(30.0, 30.0),
                    painter: BezierPainter(
                      color: color,
                      drawStart: index > 0,
                      drawEnd: index < processIndex,
                    ),
                  ),
                  DotIndicator(
                    size: 30.0,
                    color: color,
                    child: child,
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  CustomPaint(
                    size: const Size(15.0, 15.0),
                    painter: BezierPainter(
                      color: color,
                      drawEnd: index < 3 - 1,
                    ),
                  ),
                  OutlinedDotIndicator(
                    borderWidth: 4.0,
                    color: color,
                  ),
                ],
              );
            }
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == processIndex) {
                final prevColor = getColor(index - 1);
                final color = getColor(index);
                List<Color> gradientColors;

                if (doneProcess) {
                  gradientColors = [completeColor, completeColor];
                } else {
                  if (type == ConnectorType.start) {
                    gradientColors = [
                      Color.lerp(prevColor, color, 0.5)!,
                      color
                    ];
                  } else {
                    gradientColors = [
                      prevColor,
                      Color.lerp(prevColor, color, 0.5)!
                    ];
                  }
                }

                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: getColor(index),
                );
              }
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}

class BezierPainter extends CustomPainter {
  const BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    double angle;
    Offset offset1;
    Offset offset2;

    Path path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(
            size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
