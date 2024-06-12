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
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                      fontSize: theme.textTheme.bodySmall?.fontSize,
                      color: widget.userId == "User1"
                          ? palette.onPrimary
                          : palette.foreground),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "23:22 AM",
                      style: TextStyle(
                          fontSize: theme.textTheme.labelSmall?.fontSize,
                          fontWeight: FontWeight.bold,
                          color: widget.userId == "User1"
                              ? palette.inputFocusedHint
                              : palette.containerVariant),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Icon(Icons.done_all_rounded,
                        size: theme.textTheme.bodyLarge?.fontSize,
                        color: widget.userId == "User1"
                            ? palette.inputFocusedHint
                            : palette.containerVariant)
                  ],
                )
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


//pdf File
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
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   width: width * 0.6,
//                   decoration: BoxDecoration(
//                       color: widget.userId == "User1"
//                           ? palette.primaryVariant
//                           : palette.inverseContainer,
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: width * 0.6,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12))),
//                         child: Image.network(
//                           "https://images.unsplash.com/photo-1716321952293-caa23fcd4d96?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8",
//                           fit: BoxFit.cover,
//                           height: 80,
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Work sheet # 2.pdf",
//                               style: TextStyle(
//                                   color: widget.userId == "User1"
//                                       ? palette.onPrimary
//                                       : palette.foreground,
//                                   fontSize:
//                                       theme.textTheme.bodyMedium?.fontSize),
//                             ),
//                             Text(
//                               "1 pages ⋅ 66kB ⋅  PDF",
//                               style: TextStyle(
//                                   color: widget.userId == "User1"
//                                       ? palette.inputFocusedHint
//                                       : palette.containerVariant,
//                                   fontSize:
//                                       theme.textTheme.labelSmall?.fontSize),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: Row(
//                     children: [
//                       Text(
//                         "23:22 AM",
//                         style: TextStyle(
//                             fontSize: theme.textTheme.labelSmall?.fontSize,
//                             color: widget.userId == "User1"
//                                 ? palette.inputFocusedHint
//                                 : palette.containerVariant),
//                       ),
//                       const SizedBox(
//                         width: 4,
//                       ),
//                       Visibility(
//                           visible: widget.userId == "User1",
//                           child: Icon(Icons.done_all_rounded,
//                               size: theme.textTheme.bodyLarge?.fontSize,
//                               color: palette.success))
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )


//reply text message 
// Container(
//               constraints:
//                   BoxConstraints(minWidth: width * 0.4, maxWidth: width * 0.8),
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
//                 children: [
//                   Container(
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: widget.userId == "User1"
//                               ? palette.primaryVariant
//                               : palette.inverseContainer),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 64,
//                             width: 6,
//                             color: widget.userId == "User1"
//                                 ? palette.success
//                                 : palette.primary,
//                           ),
//                           const SizedBox(
//                             width: 6,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 "You",
//                                 style: TextStyle(
//                                     fontSize:
//                                         theme.textTheme.bodySmall?.fontSize,
//                                     color: widget.userId == "User1"
//                                         ? palette.success
//                                         : palette.primary,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Container(
//                                 constraints: BoxConstraints(
//                                     minWidth: width * 0.4 - 32,
//                                     maxWidth: width * 0.8 - 32),
//                                 child: Text(
//                                   "Ours was related to distributed systems Ours was related to distributed systems",
//                                   softWrap: true,
//                                   style: TextStyle(
//                                       fontSize:
//                                           theme.textTheme.bodySmall?.fontSize,
//                                       color: widget.userId != "User1"
//                                           ? palette.foreground.withOpacity(0.4)
//                                           : palette.inputFocusedHint),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             width: 6,
//                           ),
//                         ],
//                       )),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Hello",
//                           style: TextStyle(
//                               fontSize: theme.textTheme.bodySmall?.fontSize,
//                               color: widget.userId == "User1"
//                                   ? palette.onPrimary
//                                   : palette.foreground),
//                         ),
//                         const SizedBox(
//                           height: 4,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               "23:22 AM",
//                               style: TextStyle(
//                                   fontSize:
//                                       theme.textTheme.labelSmall?.fontSize,
//                                   fontWeight: FontWeight.bold,
//                                   color: widget.userId == "User1"
//                                       ? palette.inputFocusedHint
//                                       : palette.containerVariant),
//                             ),
//                             const SizedBox(
//                               width: 4,
//                             ),
//                             Visibility(
//                                 visible: widget.userId == "User1",
//                                 child: Icon(Icons.done_all_rounded,
//                                     size: theme.textTheme.bodyLarge?.fontSize,
//                                     color: widget.userId == "User1"
//                                         ? palette.success
//                                         : palette.containerVariant))
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )),


//poll

// IntrinsicWidth(
//             child: Container(
//               constraints:
//                   BoxConstraints(minWidth: width * 0.4, maxWidth: width * 0.8),
//               clipBehavior: Clip.antiAlias,
//               padding: EdgeInsets.zero,
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
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: width * 0.6,
//                     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "1234",
//                           style: TextStyle(
//                               fontSize: theme.textTheme.titleSmall?.fontSize,
//                               fontWeight: FontWeight.bold,
//                               color: widget.userId == "User1"
//                                   ? palette.onPrimary
//                                   : palette.foreground),
//                         ),
//                         const SizedBox(
//                           height: 4,
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.check_circle_outline,
//                                 size: theme.textTheme.labelLarge?.fontSize,
//                                 color: widget.userId == "User1"
//                                     ? palette.inputFocusedHint
//                                     : palette.foreground.withOpacity(0.4)),
//                             const SizedBox(
//                               width: 4,
//                             ),
//                             Text(
//                               "Select one or more",
//                               style: TextStyle(
//                                   fontSize:
//                                       theme.textTheme.labelSmall?.fontSize,
//                                   color: widget.userId == "User1"
//                                       ? palette.inputFocusedHint
//                                       : palette.foreground.withOpacity(0.4)),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Container(
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.check_circle,
//                                     color: widget.userId == "User1"
//                                         ? palette.success
//                                         : palette.primary,
//                                   ),
//                                   const SizedBox(
//                                     width: 2,
//                                   ),
//                                   Text(
//                                     "1",
//                                     style: TextStyle(
//                                         color: widget.userId == "User1"
//                                             ? palette.onPrimary
//                                             : palette.foreground,
//                                         fontSize: theme
//                                             .textTheme.bodyLarge?.fontSize),
//                                   ),
//                                   const Spacer(),
//                                   CircleAvatar(
//                                     backgroundColor:
//                                         palette.foreground.withOpacity(0.2),
//                                     radius: 10,
//                                   ),
//                                   const SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text(
//                                     "1",
//                                     style: TextStyle(
//                                         color: widget.userId == "User1"
//                                             ? palette.onPrimary
//                                             : palette.foreground,
//                                         fontSize: theme
//                                             .textTheme.labelMedium?.fontSize),
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 28,
//                                   ),
//                                   Expanded(
//                                     child: LinearProgressIndicator(
//                                       backgroundColor: widget.userId == "User1"
//                                           ? palette.foreground.withOpacity(0.2)
//                                           : palette.foreground.withOpacity(0.2),
//                                       color: widget.userId == "User1"
//                                           ? palette.success
//                                           : palette.primary,
//                                       borderRadius: BorderRadius.circular(100),
//                                       minHeight: 8,
//                                       value: 0.4,
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.circle_outlined,
//                                     color: widget.userId == "User1"
//                                         ? palette.background.withOpacity(0.2)
//                                         : palette.foreground.withOpacity(0.2),
//                                   ),
//                                   const SizedBox(
//                                     width: 2,
//                                   ),
//                                   Text(
//                                     "2",
//                                     style: TextStyle(
//                                         color: widget.userId == "User1"
//                                             ? palette.onPrimary
//                                             : palette.foreground,
//                                         fontSize: theme
//                                             .textTheme.bodyLarge?.fontSize),
//                                   ),
//                                   const Spacer(),
//                                   // CircleAvatar(
//                                   //   backgroundColor:
//                                   //       palette.foreground.withOpacity(0.2),
//                                   //   radius: 10,
//                                   // ),
//                                   // const SizedBox(
//                                   //   width: 4,
//                                   // ),
//                                   Text(
//                                     "0",
//                                     style: TextStyle(
//                                         color: widget.userId == "User1"
//                                             ? palette.onPrimary
//                                             : palette.foreground,
//                                         fontSize: theme
//                                             .textTheme.labelMedium?.fontSize),
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 28,
//                                   ),
//                                   Expanded(
//                                     child: LinearProgressIndicator(
//                                       backgroundColor: widget.userId == "User1"
//                                           ? palette.foreground.withOpacity(0.2)
//                                           : palette.foreground.withOpacity(0.2),
//                                       color: widget.userId == "User1"
//                                           ? palette.success
//                                           : palette.primary,
//                                       borderRadius: BorderRadius.circular(100),
//                                       minHeight: 8,
//                                       value: 0,
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
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
//                   Container(
//                     height: 1,
//                     width: double.infinity,
//                     color: widget.userId == "User1"
//                         ? palette.background.withOpacity(0.1)
//                         : palette.foreground.withOpacity(0.1),
//                   ),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           shape: BeveledRectangleBorder(),
//                           fixedSize: Size.fromWidth(width * 0.6),
//                           foregroundColor: widget.userId == "User1"
//                               ? palette.success
//                               : palette.primary),
//                       onPressed: () {},
//                       child: Text(
//                         "View Votes",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ))
//                 ],
//               ),
//             ),
//           )



// conttact

// IntrinsicWidth(
//             child: Container(
//               constraints:
//                   BoxConstraints(minWidth: width * 0.4, maxWidth: width * 0.8),
//               clipBehavior: Clip.antiAlias,
//               padding: EdgeInsets.only(top: 8),
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
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: width * 0.6,
//                     padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: palette.foreground.withOpacity(0.2),
//                         ),
//                         const SizedBox(
//                           width: 8,
//                         ),
//                         Text(
//                           "Hamza Nauman",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: widget.userId == "User1"
//                                   ? palette.success
//                                   : palette.primary,
//                               fontSize: theme.textTheme.titleSmall?.fontSize),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
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
//                   Container(
//                     height: 1,
//                     width: double.infinity,
//                     color: widget.userId == "User1"
//                         ? palette.background.withOpacity(0.1)
//                         : palette.foreground.withOpacity(0.1),
//                   ),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           shape: BeveledRectangleBorder(),
//                           fixedSize: Size.fromWidth(width * 0.6),
//                           foregroundColor: widget.userId == "User1"
//                               ? palette.success
//                               : palette.primary),
//                       onPressed: () {},
//                       child: Text(
//                         "Message",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ))
//                 ],
//               ),
//             ),
//           )



//link

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
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   width: width * 0.6,
//                   decoration: BoxDecoration(
//                       color: widget.userId == "User1"
//                           ? palette.primaryVariant
//                           : palette.inverseContainer,
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: width * 0.6,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12))),
//                         child: Image.network(
//                           "https://images.unsplash.com/photo-1716321952293-caa23fcd4d96?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8",
//                           fit: BoxFit.cover,
//                           height: 200,
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Lee Seob's Love",
//                               style: TextStyle(
//                                   color: widget.userId == "User1"
//                                       ? palette.onPrimary
//                                       : palette.foreground,
//                                   fontSize:
//                                       theme.textTheme.bodyMedium?.fontSize),
//                             ),
//                             Text(
//                               "Read manhwa Lee Seob's Love",
//                               style: TextStyle(
//                                   color: widget.userId == "User1"
//                                       ? palette.onPrimary.withOpacity(0.8)
//                                       : palette.foreground.withOpacity(0.4),
//                                   fontSize:
//                                       theme.textTheme.bodySmall?.fontSize),
//                             ),
//                             Text(
//                               "kunmanga.com",
//                               style: TextStyle(
//                                   color: widget.userId == "User1"
//                                       ? palette.inputFocusedHint
//                                       : palette.containerVariant,
//                                   fontSize:
//                                       theme.textTheme.labelSmall?.fontSize),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   width: width * 0.6,
//                   child: Text(
//                     "https://images.unsplash.com/photo-1716321952293-caa23fcd4d96?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8",
//                     softWrap: true,
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         color: widget.userId == "User1"
//                             ? palette.success
//                             : palette.primary,
//                         fontSize: theme.textTheme.bodySmall?.fontSize),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: Row(
//                     children: [
//                       Text(
//                         "23:22 AM",
//                         style: TextStyle(
//                             fontSize: theme.textTheme.labelSmall?.fontSize,
//                             color: widget.userId == "User1"
//                                 ? palette.inputFocusedHint
//                                 : palette.containerVariant),
//                       ),
//                       const SizedBox(
//                         width: 4,
//                       ),
//                       Visibility(
//                           visible: widget.userId == "User1",
//                           child: Icon(Icons.done_all_rounded,
//                               size: theme.textTheme.bodyLarge?.fontSize,
//                               color: palette.success))
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )