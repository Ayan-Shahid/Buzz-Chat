import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Document extends StatefulWidget {
  const Document({Key? key}) : super(key: key);

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        flexibleSpace: Container(
          color: palette.background,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: palette.foreground,
          ),
          onPressed: () {},
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: palette.foreground,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list_rounded,
              color: palette.foreground,
            ),
            onPressed: () {},
          ),
        ],
        title: Text(
          "Documents",
          style: TextStyle(
              fontSize: theme.textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.w500,
              color: palette.foreground),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: palette.container),
                      bottom: BorderSide(color: palette.container))),
              child: Column(
                children: [
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          backgroundColor: palette.background,
                          foregroundColor: palette.foreground,
                          elevation: 0.0,
                          shape: BeveledRectangleBorder()),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.storage_rounded,
                            color: palette.primary,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Browse documents",
                                style: TextStyle(
                                    color: palette.foreground,
                                    fontSize:
                                        theme.textTheme.bodyLarge?.fontSize),
                              ),
                              Text(
                                "Select files up to 2GB in size",
                                style: TextStyle(
                                    color: palette.containerVariant,
                                    fontSize:
                                        theme.textTheme.bodySmall?.fontSize),
                              ),
                            ],
                          )
                        ],
                      )),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          backgroundColor: palette.background,
                          foregroundColor: palette.foreground,
                          elevation: 0.0,
                          shape: BeveledRectangleBorder()),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.image_rounded,
                            color: palette.primary,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose from gallery",
                                style: TextStyle(
                                    color: palette.foreground,
                                    fontSize:
                                        theme.textTheme.bodyLarge?.fontSize),
                              ),
                              Text(
                                "Select original quality photos or videos",
                                style: TextStyle(
                                    color: palette.containerVariant,
                                    fontSize:
                                        theme.textTheme.bodySmall?.fontSize),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Recents",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: theme.textTheme.bodyMedium?.fontSize),
                )),
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: palette.background,
                    foregroundColor: palette.foreground,
                    shape: BeveledRectangleBorder(),
                    padding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
                child: Row(
                  children: [
                    Icon(Icons.document_scanner_sharp),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose from gallery",
                          style: TextStyle(
                              color: palette.foreground,
                              fontSize: theme.textTheme.bodyLarge?.fontSize),
                        ),
                        SizedBox(
                          width: width - 72,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "35kB",
                                style: TextStyle(
                                    color: palette.containerVariant,
                                    fontSize:
                                        theme.textTheme.bodySmall?.fontSize),
                              ),
                              Text(
                                "21/02/2024",
                                style: TextStyle(
                                    color: palette.containerVariant,
                                    fontSize:
                                        theme.textTheme.bodySmall?.fontSize),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
