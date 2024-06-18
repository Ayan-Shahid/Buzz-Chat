import 'package:buzzchat/components/screens/attachment/document/browse/document_list.dart';
import 'package:buzzchat/components/screens/attachment/document/browse/header.dart';
import 'package:buzzchat/components/screens/attachment/document/browse/input.dart';

import 'package:buzzchat/components/screens/attachment/document/browse/option_button.dart';
import 'package:buzzchat/screens/attachment/gallery/gallery.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  bool showInput = false;
  toggleInput() {
    setState(() {
      showInput = !showInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    return BrowseInherited(
        showInput: showInput,
        toggleInput: toggleInput,
        child: Scaffold(
          backgroundColor: palette.background,
          appBar: showInput
              ? PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Input())
              : PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: const Header()),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: showInput ? 16 : 0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: palette.container),
                          bottom: BorderSide(color: palette.container))),
                  child: Column(
                    children: [
                      const OptionButton(
                          title: "Browse documents",
                          label: "Select files up to 2GB in size",
                          icon: Icons.storage_rounded),
                      OptionButton(
                        title: "Choose from gallery",
                        label: "Select original quality photos or videos",
                        icon: Icons.image_rounded,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (context) => Gallery());
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Recents",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: theme.textTheme.bodyMedium?.fontSize),
                    )),
                const DocumentList()
              ],
            ),
          )),
        ));
  }
}

class BrowseInherited extends InheritedWidget {
  final bool showInput;
  final Function() toggleInput;
  final Widget child;
  const BrowseInherited(
      {Key? key,
      required this.showInput,
      required this.toggleInput,
      required this.child})
      : super(key: key, child: child);

  static BrowseInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BrowseInherited>();
  }

  @override
  bool updateShouldNotify(BrowseInherited oldWidget) {
    return oldWidget.showInput != showInput;
  }
}
