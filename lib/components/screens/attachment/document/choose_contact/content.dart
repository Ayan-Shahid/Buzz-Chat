import 'package:buzzchat/components/screens/attachment/document/choose_contact/contact.dart';
import 'package:buzzchat/screens/attachment/document/choose_contact.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  final String title;
  const Content({Key? key, required this.title}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    ChooseContactInherited? data = ChooseContactInherited.of(context);
    Size size = MediaQuery.of(context).size;
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return Column(
      children: [
        Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: palette.containerVariant,
                  fontWeight: FontWeight.w800,
                  fontSize: theme.textTheme.bodyMedium?.fontSize),
            )),
        const SizedBox(
          height: 12,
        ),
        Column(
          children: List.filled(
              4,
              Contact(
                selected: data?.contacts.contains("HaMzA_kAzMi_") ?? false,
                onPressed: () => data?.selectContact("HaMzA_kAzMi_"),
              )),
        ),
      ],
    );
  }
}
