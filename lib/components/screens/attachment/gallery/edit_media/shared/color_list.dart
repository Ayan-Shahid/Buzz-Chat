import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

final List<Color> colors = [
  Colors.black,
  Colors.white,
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.brown,
  Colors.cyan,
  Colors.orange,
  Colors.purple,
  Colors.indigo,
  Colors.lime,
  Colors.pink,
  Colors.teal,
  Colors.yellow
];

class ColorList extends StatefulWidget {
  final void Function(Color color)? onColorChanged;
  const ColorList({Key? key, this.onColorChanged}) : super(key: key);

  @override
  _ColorListState createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {
  Color selectedColor = Colors.white;

  void setSelectedColor(int index) {
    setState(() {
      selectedColor = colors[index];
    });
    widget.onColorChanged!(selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return ListView.builder(
        itemCount: colors.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => TextButton(
              onPressed: () {
                setSelectedColor(index);
              },
              style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  backgroundColor: colors[index],
                  foregroundColor: colors[index],
                  shape: CircleBorder(
                      side: BorderSide(
                          color: palette.background,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: selectedColor == colors[index] ? 6 : 3))),
              child: const Text(
                "",
              ),
            ));
  }
}
