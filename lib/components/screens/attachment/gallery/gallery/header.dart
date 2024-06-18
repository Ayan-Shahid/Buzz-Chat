import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      color: palette.inverseContainer,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close_rounded),
            color: palette.foreground,
          ),
          Text(
            "Send to hasan",
            style: TextStyle(
                color: palette.foreground,
                fontWeight: FontWeight.w400,
                fontSize: theme.textTheme.titleLarge?.fontSize),
          ),
          const Spacer(),
          PopupMenuButton(
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (context) => [],
          ),
        ],
      ),
    );
  }
}
