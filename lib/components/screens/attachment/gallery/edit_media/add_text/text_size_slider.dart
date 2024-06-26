import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class SpoonHandlePainter extends CustomPainter {
  final double handlePosition;
  final double containerHeight;
  final Color handleColor;
  final Color trackColor;

  SpoonHandlePainter(this.handlePosition, this.containerHeight,
      this.handleColor, this.trackColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint spoonPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.fill;

    Paint circlePaint = Paint()
      ..color = handleColor
      ..style = PaintingStyle.fill;

    // Draw spoon handle
    Path spoonPath = Path();
    spoonPath.moveTo(0, 6);
    spoonPath.cubicTo(0, 0, size.width, 0, size.width, 6);
    spoonPath.lineTo(size.width / 2 + 2, size.height);
    spoonPath.cubicTo(size.width / 2 + 2, size.height + 4, size.width / 2 - 2,
        size.height + 4, size.width / 2 - 2, size.height);
    spoonPath.lineTo(0, 6);

    canvas.drawPath(spoonPath, spoonPaint);

    // Draw circular handle
    double handleRadius = 8;
    double handleCenterY = handlePosition.clamp(
        0 + handleRadius, containerHeight - handleRadius + 8);
    canvas.drawCircle(
        Offset(size.width / 2, handleCenterY), handleRadius, circlePaint);

    // Draw icons at top and bottom ends of the slider
    IconData topIcon = Icons.text_increase_rounded;
    IconData bottomIcon = Icons.text_decrease_rounded;

    TextPainter topIconPainter =
        _createTextPainter(topIcon, size, TextAlign.center);
    topIconPainter.paint(
        canvas, Offset((size.width - topIconPainter.width - 8) / 2, -28));

    TextPainter bottomIconPainter =
        _createTextPainter(bottomIcon, size, TextAlign.center);
    bottomIconPainter.paint(
        canvas,
        Offset(
            (size.width - bottomIconPainter.width - 8) / 2, size.height + 8));
  }

  TextPainter _createTextPainter(IconData icon, Size size, TextAlign align) {
    TextSpan span = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: icon.fontFamily,
      ),
    );

    TextPainter painter = TextPainter(
      text: span,
      textAlign: align,
      textDirection: TextDirection.ltr,
    );

    painter.layout(minWidth: 0, maxWidth: size.width);

    return painter;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TextSizeSlider extends StatefulWidget {
  final void Function(double value)? onSliderUpdated;
  const TextSizeSlider({super.key, this.onSliderUpdated});
  @override
  _TextSizeSliderState createState() => _TextSizeSliderState();
}

class _TextSizeSliderState extends State<TextSizeSlider> {
  double _sliderValue = 0.5; // Initial slider value
  double _handlePosition =
      100; // Initial handle position (corresponds to _sliderValue = 0.5)
  double _containerHeight = 164; // Height of the slider container
  void _updateSliderValue() {
    // Update _sliderValue based on the current handle position
    double range = 1.0 - 0.2; // Range of slider values (from 0.1 to 1.0)
    double proportion = 1.0 -
        (_handlePosition /
            _containerHeight); // Calculate proportion from handle position
    _sliderValue = 0.2 + (proportion * range); // Adjust to the desired range
    widget.onSliderUpdated!(_sliderValue);
  }

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    return Center(
      child: GestureDetector(
        onVerticalDragStart: (DragStartDetails details) {
          // Calculate the initial position of the handle based on the tap location
          setState(() {
            _handlePosition = details.localPosition.dy;
            _updateSliderValue();
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          // Update handle position based on vertical drag
          setState(() {
            _handlePosition += details.primaryDelta!;

            if (_handlePosition < 0) {
              _handlePosition = 0;
            } else if (_handlePosition > _containerHeight) {
              _handlePosition = _containerHeight;
            }
            _updateSliderValue();
          });
        },
        child: CustomPaint(
          size: Size(8, _containerHeight),
          painter: SpoonHandlePainter(_handlePosition, _containerHeight,
              palette.background, palette.background.withOpacity(0.4)),
        ),
      ),
    );
  }
}
