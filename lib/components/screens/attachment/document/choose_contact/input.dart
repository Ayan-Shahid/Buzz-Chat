import 'package:buzzchat/screens/attachment/document/choose_contact.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget implements PreferredSizeWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  TextInputType keyboard = TextInputType.text;

  setKeyboard() {
    if (keyboard == TextInputType.text) {
      setState(() {
        keyboard = TextInputType.phone;
      });
    } else {
      setState(() {
        keyboard = TextInputType.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Container(
      color: palette.background,
      margin: EdgeInsets.only(top: 48),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: TextField(
        keyboardType: keyboard,
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
            hintText: "Search name or number...",
            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? palette.primary
                    : palette.foreground),
            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? palette.primary
                    : palette.foreground),
            suffixIcon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: IconButton(
                onPressed: setKeyboard,
                icon: Icon(keyboard == TextInputType.text
                    ? Icons.keyboard_outlined
                    : Icons.dialpad),
              ),
            ),
            prefixIcon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: IconButton(
                onPressed: ChooseContactInherited.of(context)?.toggle,
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            )),
      ),
    );
  }
}
