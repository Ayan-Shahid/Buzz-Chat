import 'package:buzzchat/enums/message.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({Key? key, required this.userId, required this.type})
      : super(key: key);
  final String userId;
  final MessageType type;

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      alignment: widget.userId == "User1"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection:
            widget.userId == "User1" ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            radius: width * 0.04,
            backgroundColor: palette.container,
          ),
          const SizedBox(
            width: 12,
          ),
          Container(
            constraints: BoxConstraints(minWidth: width * 0.4),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: widget.userId == "User1"
                    ? palette.primary
                    : palette.container,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.userId == "User1" ? 16 : 4),
                    topRight:
                        Radius.circular(widget.userId == "User1" ? 4 : 16),
                    bottomLeft: const Radius.circular(16),
                    bottomRight: const Radius.circular(16))),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: width * 0.6,
                  decoration: BoxDecoration(
                      color: widget.userId == "User1"
                          ? palette.primaryVariant
                          : palette.inverseContainer,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.6,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1716321952293-caa23fcd4d96?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8",
                          fit: BoxFit.cover,
                          height: 80,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Work sheet # 2.pdf",
                              style: TextStyle(
                                  color: widget.userId == "User1"
                                      ? palette.onPrimary
                                      : palette.foreground,
                                  fontSize:
                                      theme.textTheme.bodyMedium?.fontSize),
                            ),
                            Text(
                              "1 ⋅ page 66kB ⋅  PDF",
                              style: TextStyle(
                                  color: widget.userId == "User1"
                                      ? palette.inputFocusedHint
                                      : palette.containerVariant,
                                  fontSize:
                                      theme.textTheme.labelSmall?.fontSize),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        "23:22 AM",
                        style: TextStyle(
                            fontSize: theme.textTheme.labelSmall?.fontSize,
                            color: widget.userId == "User1"
                                ? palette.inputFocusedHint
                                : palette.containerVariant),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Visibility(
                          visible: widget.userId == "User1",
                          child: Icon(Icons.done_all_rounded,
                              size: theme.textTheme.bodyLarge?.fontSize,
                              color: palette.success))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//text only

// Container(
//               constraints: BoxConstraints(minWidth: width * 0.4),
//               decoration: BoxDecoration(
//                   color: widget.userId == "User1"
//                       ? palette.primary
//                       : palette.container,
//                   borderRadius: BorderRadius.only(
//                       topLeft:
//                           Radius.circular(widget.userId == "User1" ? 16 : 4),
//                       topRight:
//                           Radius.circular(widget.userId == "User1" ? 4 : 16),
//                       bottomLeft: const Radius.circular(16),
//                       bottomRight: const Radius.circular(16))),
//               padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//               child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Hello",
//                   style: TextStyle(
//                       fontSize: theme.textTheme.bodySmall?.fontSize,
//                       color: widget.userId == "User1"
//                           ? palette.onPrimary
//                           : palette.foreground),
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "23:22 AM",
//                       style: TextStyle(
//                           fontSize: theme.textTheme.labelSmall?.fontSize,
//                           fontWeight: FontWeight.bold,
//                           color: widget.userId == "User1"
//                               ? palette.inputFocusedHint
//                               : palette.containerVariant),
//                     ),
//                     const SizedBox(
//                       width: 4,
//                     ),
//                     Icon(Icons.done_all_rounded,
//                         size: theme.textTheme.bodyLarge?.fontSize,
//                         color: widget.userId == "User1"
//                             ? palette.inputFocusedHint
//                             : palette.containerVariant)
//                   ],
//                 )
//               ],
//             ),)


//image without text

// Container(
//               constraints: BoxConstraints(minWidth: width * 0.4),
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(
//                   color: widget.userId == "User1"
//                       ? palette.primary
//                       : palette.container,
//                   borderRadius: BorderRadius.only(
//                       topLeft:
//                           Radius.circular(widget.userId == "User1" ? 16 : 4),
//                       topRight:
//                           Radius.circular(widget.userId == "User1" ? 4 : 16),
//                       bottomLeft: const Radius.circular(16),
//                       bottomRight: const Radius.circular(16))),
//               padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//               child: Stack(
//                 children: [
//                   Container(
//                     width: 200,
//                     clipBehavior: Clip.antiAlias,
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(12)),
//                     child: Image.network(
//                       "https://images.unsplash.com/photo-1716321952293-caa23fcd4d96?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8",
//                       fit: BoxFit.scaleDown,
//                     ),
//                   ),
//                   Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         alignment: Alignment.bottomRight,
//                         height: 100,
//                         width: 200,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(24)),
//                         child: FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Container(
//                             decoration: BoxDecoration(boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 24,
//                               )
//                             ]),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "23:22 AM",
//                                   style: TextStyle(
//                                       fontSize:
//                                           theme.textTheme.labelSmall?.fontSize,
//                                       color: widget.userId == "User1"
//                                           ? palette.onPrimary
//                                           : palette.background),
//                                 ),
//                                 const SizedBox(
//                                   width: 4,
//                                 ),
//                                 Visibility(
//                                     visible: widget.userId == "User1",
//                                     child: Icon(Icons.done_all_rounded,
//                                         size:
//                                             theme.textTheme.bodyLarge?.fontSize,
//                                         color: palette.primary))
//                               ],
//                             ),
//                           ),
//                         ),
//                       ))
//                 ],
//               ))


//image with text

// Container(
//               constraints: BoxConstraints(minWidth: width * 0.4),
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(
//                   color: widget.userId == "User1"
//                       ? palette.primary
//                       : palette.container,
//                   borderRadius: BorderRadius.only(
//                       topLeft:
//                           Radius.circular(widget.userId == "User1" ? 16 : 4),
//                       topRight:
//                           Radius.circular(widget.userId == "User1" ? 4 : 16),
//                       bottomLeft: const Radius.circular(16),
//                       bottomRight: const Radius.circular(16))),
//               padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: 200,
//                     clipBehavior: Clip.antiAlias,
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(12)),
//                     child: Image.network(
//                       "https://images.unsplash.com/photo-1716321952293-caa23fcd4d96?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8",
//                       fit: BoxFit.scaleDown,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//                     width: 200,
//                     child: Text(
//                       "lorem ipsum",
//                       softWrap: true,
//                       style: TextStyle(
//                           fontSize: theme.textTheme.bodySmall?.fontSize,
//                           fontWeight: FontWeight.w400,
//                           color: widget.userId == "User1"
//                               ? palette.onPrimary
//                               : palette.foreground),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//                     child: Row(
//                       children: [
//                         Text(
//                           "23:22 AM",
//                           style: TextStyle(
//                               fontSize: theme.textTheme.labelSmall?.fontSize,
//                               color: widget.userId == "User1"
//                                   ? palette.inputFocusedHint
//                                   : palette.containerVariant),
//                         ),
//                         const SizedBox(
//                           width: 4,
//                         ),
//                         Visibility(
//                             visible: widget.userId == "User1",
//                             child: Icon(Icons.done_all_rounded,
//                                 size: theme.textTheme.bodyLarge?.fontSize,
//                                 color: palette.success))
//                       ],
//                     ),
//                   ),
//                 ],
//               ))



//multiple images


// Container(
//             constraints: BoxConstraints(minWidth: width * 0.4),
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//                 color: widget.userId == "User1"
//                     ? palette.primary
//                     : palette.container,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(widget.userId == "User1" ? 16 : 4),
//                     topRight:
//                         Radius.circular(widget.userId == "User1" ? 4 : 16),
//                     bottomLeft: const Radius.circular(16),
//                     bottomRight: const Radius.circular(16))),
//             padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//             child: Container(
//                 width: width * 0.6,
//                 decoration: const BoxDecoration(),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   itemCount: 4,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 6,
//                       crossAxisSpacing: 6),
//                   itemBuilder: (context, index) {
//                     return Stack(
//                       children: [
//                         Positioned.fill(
//                           child: Container(
//                             clipBehavior: Clip.antiAlias,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12)),
//                             child: Image.network(
//                               "https://images.unsplash.com/photo-1716321952293-caa23fcd4d96?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8",
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: Container(
//                               alignment: Alignment.bottomRight,
//                               height: 100,
//                               width: 100,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(24)),
//                               child: FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 child: Container(
//                                   decoration: BoxDecoration(boxShadow: [
//                                     BoxShadow(
//                                       blurRadius: 24,
//                                     )
//                                   ]),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 4),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         "23:22 AM",
//                                         style: TextStyle(
//                                             fontSize: theme
//                                                 .textTheme.labelSmall?.fontSize,
//                                             color: widget.userId == "User1"
//                                                 ? palette.onPrimary
//                                                 : palette.background),
//                                       ),
//                                       const SizedBox(
//                                         width: 4,
//                                       ),
//                                       Visibility(
//                                           visible: widget.userId == "User1",
//                                           child: Icon(Icons.done_all_rounded,
//                                               size: theme.textTheme.bodyLarge
//                                                   ?.fontSize,
//                                               color: palette.primary))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ))
//                       ],
//                     );
//                   },
//                 )),
//           )