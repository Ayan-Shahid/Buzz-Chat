import 'package:buzzchat/components/attachment_button.dart';
import 'package:buzzchat/components/chat_bubble.dart';
import 'package:buzzchat/components/chat_input.dart';
import 'package:buzzchat/components/send_message_button.dart';
import 'package:buzzchat/enums/message.dart';
import 'package:buzzchat/firebase_options.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

extension MediaQuerySize on BuildContext {
  Size get screen => MediaQuery.of(this).size;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BuzzChatTheme>(
      create: (context) => BuzzChatTheme(),
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: BuzzChatTheme.light,
        darkTheme: BuzzChatTheme.dark,
        themeMode: context.watch<BuzzChatTheme>().themeMode,
        home: const Chat(),
      ),
    );
  }
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, String>> messages = [
    {"from": "User1", "message": "Hello", "type": "text"},
    {"from": "User2", "message": "Hello", "type": "text"},
    {"from": "User1", "message": "", "type": "image"},
    {"from": "User1", "message": "", "type": "voice"},
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.phone_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
        ],
        centerTitle: false,
        titleSpacing: 0,
        flexibleSpace: Container(
          color: palette.container,
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: palette.inverseContainer,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User 1",
                  style: TextStyle(
                      fontSize: theme.textTheme.titleMedium?.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Online",
                  style: TextStyle(
                      fontSize: theme.textTheme.bodySmall?.fontSize,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
        backgroundColor: palette.container,
        shape: Border(bottom: BorderSide(color: palette.inverseContainer)),
        foregroundColor: palette.foreground,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: ShapeDecoration(
                        shape: const StadiumBorder(), color: palette.container),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "6:32 AM",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: theme.textTheme.labelSmall?.fontSize,
                      color: palette.containerVariant),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: ShapeDecoration(
                        shape: const StadiumBorder(), color: palette.container),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ChatBubble(
                      userId: messages[index]["from"]!,
                      type: messages[index]["type"] == "text"
                          ? MessageType.text
                          : MessageType.image);
                },
                itemCount: messages.length,
                shrinkWrap: true,
              ),
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AttachmentButton(),
                SizedBox(
                  width: 8,
                ),
                ChatInput(),
                SizedBox(
                  width: 8,
                ),
                SendMessageButton()
              ],
            )
          ],
        ),
      )),
    );
  }
}
