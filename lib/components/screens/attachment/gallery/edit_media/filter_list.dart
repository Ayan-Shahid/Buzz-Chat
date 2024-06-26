import 'dart:io';

import 'package:buzzchat/components/screens/attachment/gallery/edit_media/filter_matrix.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  final String imagePath;
  const FilterList({Key? key, required this.imagePath}) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    EditMediaInherited data = EditMediaInherited.of(context)!;
    return Container(
      width: width,
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      height: 140,
      color: BuzzChatPalette.grayscale.grayscale300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: FilterMatrix.filters.length,
        clipBehavior: Clip.none,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              data.selectFilter(index);
            },
            child: AnimatedScale(
              alignment: Alignment.topCenter,
              scale: data.filter == index
                  ? 0.6 + 0.4 * (1.08 - data.filterListPosition)
                  : 0.6 + 0.4 * (1 - data.filterListPosition),
              duration: Duration(
                  milliseconds: data.filterListPosition == 0 ? 200 : 0),
              child: Container(
                width: 80,
                margin: EdgeInsets.only(left: index == 0 ? 0 : 8),
                decoration: BoxDecoration(
                  color: BuzzChatPalette.grayscale.grayscale300,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: FilterMatrix.filters[index].name == "None"
                            ? Image.file(
                                File(widget.imagePath),
                                fit: BoxFit.cover,
                              )
                            : ColorFiltered(
                                colorFilter: ColorFilter.matrix(
                                    FilterMatrix.filters[index].matrix),
                                child: Image.file(
                                  File(widget.imagePath),
                                  fit: BoxFit.cover,
                                ))),
                    Positioned(
                      bottom: 0,
                      child: Container(
                          width: 80,
                          color: palette.foreground.withOpacity(0.6),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            FilterMatrix.filters[index].name,
                            style: TextStyle(
                                color: palette.background,
                                fontWeight: FontWeight.bold,
                                fontSize: theme.textTheme.labelSmall?.fontSize),
                          )),
                    ),
                    Positioned(
                        top: 4,
                        right: 4,
                        child: AnimatedScale(
                          scale: data.filter == index ? 1 : 0,
                          duration: Duration(milliseconds: 140),
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: palette.success,
                          ),
                        )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
