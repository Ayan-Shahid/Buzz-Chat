import 'package:buzzchat/screens/attachment/document/browse.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget implements PreferredSizeWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    BrowseInherited? data = BrowseInherited.of(context);
    return Container(
      color: palette.background,
      margin: const EdgeInsets.only(top: 48),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: TextField(
        style: MaterialStateTextStyle.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? TextStyle(color: palette.onPrimaryInverse)
                : TextStyle(color: palette.foreground)),
        cursorColor: palette.primary,
        decoration: InputDecoration(
            hintStyle: MaterialStateTextStyle.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? TextStyle(color: palette.inputFocusedHint)
                    : TextStyle(color: palette.containerVariant)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: palette.primary)),
            contentPadding: EdgeInsets.symmetric(vertical: 16),
            fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? palette.primaryInputFocusedBackground
                    : palette.container),
            hintText: "Search...",
            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? palette.primary
                    : palette.foreground),
            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? palette.primary
                    : palette.foreground),
            prefixIcon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: IconButton(
                onPressed: data?.toggleInput,
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            )),
      ),
    );
  }
}
