import 'package:buzzchat/screens/attachment/document/choose_contact.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final Color? backgroundColor;
  final Color? tagColor;
  final TextStyle? textStyle;
  const Footer({Key? key, this.backgroundColor, this.tagColor, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: backgroundColor ?? palette.inverseContainer,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width - 108,
            height: 56,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(left: index == 0 ? 0 : 12),
                child: InputChip(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChooseContact()));
                  },
                  label: Text(
                    "hasan",
                    style: textStyle ??
                        TextStyle(
                            fontSize: theme.textTheme.labelLarge?.fontSize),
                  ),
                  elevation: 0.0,
                  shape: StadiumBorder(),
                  side: BorderSide(width: 0.0),
                  backgroundColor: tagColor ?? palette.container,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          IconButton(
              padding: EdgeInsets.all(16),
              style: IconButton.styleFrom(
                  backgroundColor: palette.primary,
                  foregroundColor: palette.onPrimary),
              onPressed: () {},
              icon: Icon(
                Icons.send_rounded,
                size: theme.textTheme.titleLarge?.fontSize,
              ))
        ],
      ),
    );
  }
}
