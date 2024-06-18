import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return Expanded(
      child: Container(
        color: palette.container,
        width: size.width,
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/xls.svg",
              width: 40,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "1st Sessional Examination Schedule Spring 2024 Version Final as on 20-02-2024.xlsx",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: theme.textTheme.headlineSmall?.fontSize,
                  fontWeight: FontWeight.w600,
                  color: palette.foreground),
            ),
            Text(
              "3 sheets ⋅ XLSX",
              style: TextStyle(
                  fontSize: theme.textTheme.bodyLarge?.fontSize,
                  fontWeight: FontWeight.w700,
                  color: palette.containerVariant),
            ),
            Text(
              "35 kB",
              style: TextStyle(
                  fontSize: theme.textTheme.bodyLarge?.fontSize,
                  fontWeight: FontWeight.w700,
                  color: palette.containerVariant),
            ),
          ],
        ),
      ),
    );
  }
}
