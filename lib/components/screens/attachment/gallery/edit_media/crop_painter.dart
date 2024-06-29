import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class CropPainter extends CustomPainter {
  final Rect cropRect;
  final Rect backgroundRect;

  CropPainter(this.cropRect, this.backgroundRect);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = BuzzChatPalette.grayscale.grayscale100.withOpacity(0.4)
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
                      ? boxRect.right - 2
                      : boxRect.center.dx -
                          ((boxRect.width * 0.3).clamp(16, 24) / 2),
              i == 0 && j == 1 || i == 2 && j == 1
                  ? boxRect.center.dy -
                      ((boxRect.height * 0.3).clamp(16, 24) / 2)
                  : j == 0
                      ? boxRect.top + 2
                      : boxRect.bottom - 2,
              i == 0 && j == 1
                  ? (boxHeight * 0.04).clamp(2, 4)
                  : i == 2 && j == 1
                      ? (-boxHeight * 0.04).clamp(-4, -2)
                      : (boxRect.width * 0.3).clamp(16, 24),
              i == 0 && j == 1 || i == 2 && j == 1
                  ? (boxRect.height * 0.3).clamp(16, 24)
                  : i == 1 && j == 2
                      ? (-boxHeight * 0.04).clamp(-4, -2)
                      : (boxHeight * 0.04).clamp(2, 4));

          canvas.drawRect(
              handleRect,
              Paint()
                ..color = BuzzChatPalette.grayscale.grayscale1000
                ..style = PaintingStyle.fill);
        }

        if ((i == 0 && j == 0) ||
            (i == 2 && j == 0) ||
            (i == 0 && j == 2) ||
            (i == 2 && j == 2)) {
          Rect cornerRectDown = Rect.zero;
          Rect cornerRectUp = Rect.zero;

          if (i == 0 && j == 0) {
            cornerRectUp = Rect.fromLTWH(
                boxRect.left + 4,
                boxRect.top + 2,
                (boxRect.height * 0.2).clamp(16, 24),
                (boxHeight * 0.04).clamp(2, 4));
            cornerRectDown = Rect.fromLTWH(
                boxRect.left + 2,
                boxRect.top + 2,
                (boxHeight * 0.04).clamp(2, 4),
                (boxRect.height * 0.2).clamp(16, 24));
          } else if (i == 2 && j == 2) {
            cornerRectUp = Rect.fromLTWH(
                boxRect.right - 2,
                boxRect.bottom - 2,
                (-boxRect.height * 0.2).clamp(-24, -16),
                (-boxHeight * 0.04).clamp(-4, -2));
            cornerRectDown = Rect.fromLTWH(
                boxRect.right - 2,
                boxRect.bottom - 2,
                (-boxHeight * 0.04).clamp(-4, -2),
                (-boxRect.height * 0.2).clamp(-24, -16));
          } else if (i == 2 && j == 0) {
            cornerRectUp = Rect.fromLTWH(
                boxRect.right - 2,
                boxRect.top + 2,
                (-boxRect.height * 0.2).clamp(-24, -16),
                (boxHeight * 0.04).clamp(2, 4));
            cornerRectDown = Rect.fromLTWH(
                boxRect.right - 2,
                boxRect.top + 2,
                (-boxHeight * 0.04).clamp(-4, -2),
                (boxRect.height * 0.2).clamp(16, 24));
          } else if (j == 2 && i == 0) {
            cornerRectUp = Rect.fromLTWH(
                boxRect.left + 2,
                boxRect.bottom - 2,
                (boxRect.height * 0.2).clamp(16, 24),
                (-boxHeight * 0.04).clamp(-4, -2));
            cornerRectDown = Rect.fromLTWH(
                boxRect.left + 2,
                boxRect.bottom - 2,
                (boxHeight * 0.04).clamp(2, 4),
                (-boxRect.height * 0.2).clamp(-24, -16));
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
