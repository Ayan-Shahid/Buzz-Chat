import 'package:buzzchat/components/screens/attachment/document/choose_contact/content.dart';
import 'package:buzzchat/components/screens/attachment/document/choose_contact/footer.dart';
import 'package:buzzchat/components/screens/attachment/document/choose_contact/header.dart';
import 'package:buzzchat/components/screens/attachment/document/choose_contact/input.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class ChooseContact extends StatefulWidget {
  const ChooseContact({super.key});

  @override
  ChooseContactState createState() => ChooseContactState();
}

class ChooseContactState extends State<ChooseContact> {
  List<String> contacts = [];
  void selectContact(String contact) {
    contacts.contains(contact)
        ? setState(() {
            contacts.remove(contact);
          })
        : setState(() {
            contacts.add(contact);
          });
  }

  bool showInput = false;

  void toggle() {
    setState(() {
      showInput = !showInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return ChooseContactInherited(
        contacts: contacts,
        selectContact: selectContact,
        data: showInput,
        toggle: toggle,
        child: Scaffold(
          backgroundColor: palette.background,
          appBar: showInput
              ? Input()
              : Header(
                  length: contacts.length,
                ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Content(
                      title: "Frequently Contacted",
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Content(title: "Recent Chats"),
                    const SizedBox(
                      height: 12,
                    ),
                    Content(title: "Other Contacts")
                  ],
                ),
              )),
              const SizedBox(
                height: 12,
              ),
              Footer(
                contacts: contacts,
              ),
            ],
          )),
        ));
  }
}

class ChooseContactInherited extends InheritedWidget {
  final bool data;
  final List<String> contacts;
  final void Function() toggle;
  final void Function(String contact) selectContact;
  const ChooseContactInherited(
      {Key? key,
      required Widget child,
      required this.contacts,
      required this.selectContact,
      required this.data,
      required this.toggle})
      : super(key: key, child: child);

  static ChooseContactInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChooseContactInherited>();
  }

  @override
  bool updateShouldNotify(ChooseContactInherited oldWidget) {
    return oldWidget.data != data;
  }
}
