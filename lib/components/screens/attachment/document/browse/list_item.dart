import 'package:buzzchat/screens/attachment/document/overview.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum DocumentType { pdf, xls, doc, docx, ppt, txt }

class DocumentDataModel {
  final String name;
  final num size;
  final DocumentType type;
  final DateTime date;

  const DocumentDataModel(
      {required this.name,
      required this.size,
      required this.type,
      required this.date});
}

class ListItem extends StatelessWidget {
  final DocumentDataModel data;
  const ListItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return TextButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Overview()));
        },
        style: TextButton.styleFrom(
            backgroundColor: palette.background,
            foregroundColor: palette.foreground,
            shape: BeveledRectangleBorder(),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              "assets/icons/${data.type.name}.svg",
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                      color: palette.foreground,
                      fontSize: theme.textTheme.bodyLarge?.fontSize),
                ),
                SizedBox(
                  width: width - 88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data.size}kB",
                        style: TextStyle(
                            color: palette.containerVariant,
                            fontSize: theme.textTheme.bodySmall?.fontSize),
                      ),
                      Text(
                        "${data.date.day}/${data.date.month}/${data.date.year}",
                        style: TextStyle(
                            color: palette.containerVariant,
                            fontSize: theme.textTheme.bodySmall?.fontSize),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
