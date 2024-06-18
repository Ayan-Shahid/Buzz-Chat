import 'package:buzzchat/screens/attachment/document/choose_contact.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final List<String> contacts;
  const Footer({Key? key, required this.contacts}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  num containerHeight = 72;
  int buttonRadius = 1;

  void animate(bool data) {
    if (data == true) {
      setState(() {
        containerHeight = 72;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          buttonRadius = 1;
        });
      });
    } else {
      setState(() {
        buttonRadius = 0;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          containerHeight = 0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    ChooseContactInherited? data = ChooseContactInherited.of(context);
    animate(data!.contacts.isNotEmpty);
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: containerHeight.toDouble(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: palette.container,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width - 108,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(data?.contacts.isEmpty == true
                  ? ""
                  : data!.contacts
                      .reduce((value, element) => "$value, $element")),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          AnimatedScale(
            scale: buttonRadius.toDouble(),
            duration: Duration(milliseconds: 200),
            child: IconButton(
                padding: EdgeInsets.all(16),
                style: IconButton.styleFrom(
                    backgroundColor: palette.primary,
                    foregroundColor: palette.onPrimary),
                onPressed: () {},
                icon: Icon(
                  Icons.send_rounded,
                  size: theme.textTheme.titleLarge?.fontSize,
                )),
          )
        ],
      ),
    );
  }
}
