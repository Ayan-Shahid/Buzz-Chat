import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class CropPainter extends CustomPainter {
  final Rect cropRect;
  final Rect backgroundRect;

  CropPainter(this.cropRect, this.backgroundRect);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    // Draw the border for the crop area
    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(cropRect, borderPaint);

    // Draw the 6 inner boxes
    final double boxWidth = cropRect.width / 3;
    final double boxHeight = cropRect.height / 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        final boxRect = Rect.fromLTWH(
          cropRect.left + i * boxWidth,
          cropRect.top + j * boxHeight,
          boxWidth,
          boxHeight,
        );
        canvas.drawRect(boxRect, borderPaint);
        if (i == 1 && j == 0 ||
            i == 1 && j == 2 ||
            i == 0 && j == 1 ||
            i == 2 && j == 1) {
          final handleRect = Rect.fromLTWH(
            i == 0 && j == 1
                ? boxRect.left + 2
                : i == 2 && j == 1
                    ? boxRect.right - 4
                    : boxRect.center.dx -
                        (boxRect.width * 0.3 >= boxWidth
                                ? boxWidth
                                : boxRect.width * 0.3 >= 28
                                    ? 28
                                    : boxRect.width * 0.3) /
                            2,
            i == 0 && j == 1 || i == 2 && j == 1
                ? boxRect.center.dy -
                    (boxRect.height * 0.3 >= boxHeight
                            ? boxHeight
                            : boxRect.height * 0.3 >= 28
                                ? 28
                                : boxRect.height * 0.3) /
                        2
                : j == 0
                    ? boxRect.top + 2
                    : boxRect.bottom - 4,
            i == 0 && j == 1 || i == 2 && j == 1
                ? boxWidth * 0.04 <= 2
                    ? 2
                    : boxWidth * 0.04 >= 4
                        ? 4
                        : boxWidth * 0.04
                : boxRect.width * 0.3 >= boxWidth
                    ? boxWidth
                    : boxRect.width * 0.3 >= 28
                        ? 28
                        : boxRect.width * 0.3,
            i == 0 && j == 1 || i == 2 && j == 1
                ? boxRect.height * 0.3 >= boxHeight
                    ? boxHeight
                    : boxRect.height * 0.3 >= 28
                        ? 28
                        : boxRect.height * 0.3
                : boxHeight * 0.04 <= 2
                    ? 2
                    : boxHeight * 0.04 >= 4
                        ? 4
                        : boxHeight * 0.04,
          );

          canvas.drawRect(
              handleRect,
              Paint()
                ..color = BuzzChatPalette.grayscale.grayscale1000
                ..style = PaintingStyle.fill);
        } else if (i == 0 && j == 0 ||
            i == 2 && j == 2 ||
            i == 0 && j == 2 ||
            i == 2 && j == 0) {
          Rect cornerRectUp = Rect.fromLTWH(
              boxRect.left + 2,
              boxRect.top + 2,
              boxRect.width * 0.2,
              boxHeight * 0.04 <= 2
                  ? 2
                  : boxHeight * 0.04 >= 4
                      ? 4
                      : boxHeight * 0.04);
          Rect cornerRectDown = Rect.fromLTWH(
              boxRect.left + 2,
              boxRect.top + 2,
              boxHeight * 0.04 <= 2
                  ? 2
                  : boxHeight * 0.04 >= 4
                      ? 4
                      : boxHeight * 0.04,
              boxRect.height * 0.2);

          if (i == 2 && j == 2) {
            cornerRectUp = Rect.fromLTWH(
                boxRect.right - 4,
                boxRect.bottom - 2,
                boxHeight * 0.04 <= 2
                    ? 2
                    : boxHeight * 0.04 >= 4
                        ? 4
                        : boxHeight * 0.04,
                -boxRect.height * 0.2);
            cornerRectDown = Rect.fromLTWH(
                boxRect.right - 4,
                boxRect.bottom - 4,
                -boxRect.width * 0.2,
                boxHeight * 0.04 <= 2
                    ? 2
                    : boxHeight * 0.04 >= 4
                        ? 4
                        : boxHeight * 0.04);
          } else if (i == 0 && j == 2) {
            cornerRectDown = Rect.fromLTWH(
                boxRect.left + 2,
                boxRect.bottom - 2,
                boxHeight * 0.04 <= 2
                    ? 2
                    : boxHeight * 0.04 >= 4
                        ? 4
                        : boxHeight * 0.04,
                -boxRect.height * 0.2);
            cornerRectUp = Rect.fromLTWH(
                boxRect.left + 2,
                boxRect.bottom - 4,
                boxRect.width * 0.2,
                boxHeight * 0.04 <= 2
                    ? 2
                    : boxHeight * 0.04 >= 4
                        ? 4
                        : boxHeight * 0.04);
          } else if (i == 2 && j == 0) {
            cornerRectUp = Rect.fromLTWH(
                boxRect.right - 4,
                boxRect.top + 2,
                boxHeight * 0.04 <= 2
                    ? 2
                    : boxHeight * 0.04 >= 4
                        ? 4
                        : boxHeight * 0.04,
                boxRect.height * 0.2);
            cornerRectDown = Rect.fromLTWH(
                boxRect.right - 4,
                boxRect.top + 2,
                -boxRect.width * 0.2,
                boxHeight * 0.04 <= 2
                    ? 2
                    : boxHeight * 0.04 >= 4
                        ? 4
                        : boxHeight * 0.04);
          }
          canvas.drawRect(
              cornerRectUp,
              Paint()
                ..color = BuzzChatPalette.grayscale.grayscale1000
                ..style = PaintingStyle.fill);
          canvas.drawRect(
              cornerRectDown,
              Paint()
                ..color = BuzzChatPalette.grayscale.grayscale1000
                ..style = PaintingStyle.fill);
        }
      }
    }

    canvas.drawPath(
        Path.combine(PathOperation.difference, Path()..addRect(backgroundRect),
            Path()..addRect(cropRect)),
        paint);
  }

  @override
  bool shouldRepaint(CropPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.cropRect != cropRect;
  }
}
