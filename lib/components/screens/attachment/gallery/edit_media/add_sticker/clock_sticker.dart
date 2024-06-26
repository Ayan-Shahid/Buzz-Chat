import 'dart:math';

import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class ClockSticker extends StatefulWidget {
  const ClockSticker({Key? key}) : super(key: key);

  @override
  _ClockStickerState createState() => _ClockStickerState();
}

class _ClockStickerState extends State<ClockSticker> {
  DateTime now = DateTime.now();

  double calculateMinuteAngle(DateTime time) {
    return (time.minute * 6.0) * (3.14 / 180.0); // Convert degrees to radians
  }

  double calculateHourAngle(DateTime time) {
    return ((time.hour % 12) * 30.0 + (time.minute * 0.5)) *
        (3.14 / 180.0); // Convert degrees to radians
  }

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;

    now = DateTime.now();
    double minuteAngle = calculateMinuteAngle(now);
    double hourAngle = calculateHourAngle(now);
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: palette.background,
          border: Border.all(
              width: 2,
              color: palette.foreground.withOpacity(0.4),
              strokeAlign: BorderSide.strokeAlignOutside)),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                "12",
                style: TextStyle(
                    fontSize: theme.textTheme.labelSmall?.fontSize,
                    fontWeight: FontWeight.bold),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                "3",
                style: TextStyle(
                    fontSize: theme.textTheme.labelSmall?.fontSize,
                    fontWeight: FontWeight.bold),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "6",
                style: TextStyle(
                    fontSize: theme.textTheme.labelSmall?.fontSize,
                    fontWeight: FontWeight.bold),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "9",
                style: TextStyle(
                    fontSize: theme.textTheme.labelSmall?.fontSize,
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              top: 20,
              right: 6,
              child: Transform.rotate(
                angle: 45,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Positioned(
              top: 8,
              right: 16,
              child: Transform.rotate(
                angle: pi / 6,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Positioned(
              top: 8,
              left: 16,
              child: Transform.rotate(
                angle: -pi / 6,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Positioned(
              top: 20,
              left: 6,
              child: Transform.rotate(
                angle: -45,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Positioned(
              bottom: 8,
              left: 16,
              child: Transform.rotate(
                angle: pi / 6,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Positioned(
              bottom: 20,
              left: 6,
              child: Transform.rotate(
                angle: 45,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Positioned(
              bottom: 8,
              right: 16,
              child: Transform.rotate(
                angle: -pi / 6,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Positioned(
              bottom: 20,
              right: 6,
              child: Transform.rotate(
                angle: -45,
                child: Container(
                  width: 2,
                  height: 6,
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: palette.foreground.withOpacity(0.4)),
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 10,
              height: 10,
              decoration:
                  BoxDecoration(color: palette.error, shape: BoxShape.circle),
            ),
          ),
          // Minute Handle
          Positioned(
            top: 6, // Adjust based on the circle size
            left: 35,
            // Adjust based on the circle size
            child: Transform.rotate(
              angle: minuteAngle,
              origin: Offset(0, 8),
              child: Container(
                width: 2,
                height: 48,
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: palette.error,
                ),
              ),
            ),
          ),
          //Hour Handle
          Positioned(
            top: 16, // Adjust based on the circle size
            left: 34.2, // Adjust based on the circle size
            child: Transform.rotate(
              angle: hourAngle,
              origin: Offset(0, 7),
              child: Container(
                width: 4,
                height: 32,
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: palette.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
