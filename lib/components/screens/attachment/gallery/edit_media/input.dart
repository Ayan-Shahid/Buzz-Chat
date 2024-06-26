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
  bool isEmojiKeyboard = false;
  bool viewOnce = false;
  final FocusNode focusNode = FocusNode();

  void toggleKeyboard() {
    setState(() {
      isEmojiKeyboard = !isEmojiKeyboard;
    });
  }

  void toggleViewOnce() {
    setState(() {
      viewOnce = !viewOnce;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 48),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        focusNode: focusNode,
        style: MaterialStateTextStyle.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? TextStyle(color: BuzzChatPalette.primary.primary900)
                : TextStyle(color: BuzzChatPalette.grayscale.grayscale1000)),
        cursorColor: BuzzChatPalette.primary.primary500,
        decoration: InputDecoration(
            hintStyle: MaterialStateTextStyle.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? TextStyle(color: BuzzChatPalette.primary.primary200)
                    : TextStyle(color: BuzzChatPalette.grayscale.grayscale600)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide:
                    BorderSide(color: BuzzChatPalette.primary.primary500)),
            contentPadding: EdgeInsets.symmetric(vertical: 16),
            fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? BuzzChatPalette.primary.primary100
                    : BuzzChatPalette.grayscale.grayscale400),
            hintText: "Add a caption...",
            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? BuzzChatPalette.primary.primary500
                    : BuzzChatPalette.grayscale.grayscale600),
            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? BuzzChatPalette.primary.primary500
                    : BuzzChatPalette.grayscale.grayscale600),
            suffixIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: IconButton(
                  onPressed: toggleViewOnce,
                  icon: Icon(viewOnce ? Icons.circle : Icons.circle_outlined),
                )),
            prefixIcon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: focusNode.hasFocus
                  ? IconButton(
                      onPressed: toggleKeyboard,
                      icon: Icon(isEmojiKeyboard
                          ? Icons.emoji_emotions_outlined
                          : Icons.keyboard_outlined),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                    ),
            )),
      ),
    );
  }
}
