import 'package:buzzchat/components/screens/attachment/gallery/edit_media/filter_matrix.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  const FilterList({Key? key}) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  int selected = 0;

  void select(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      height: 140,
      color: palette.container,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: FilterMatrix.filters.length,
        clipBehavior: Clip.none,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              select(index);
            },
            child: AnimatedScale(
              alignment: Alignment.bottomCenter,
              scale: selected == index ? 1.08 : 1,
              duration: Duration(milliseconds: 200),
              child: Container(
                width: 80,
                margin: EdgeInsets.only(left: index == 0 ? 0 : 8),
                decoration: BoxDecoration(
                    color: palette.inverseContainer,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1718703357732-8c7aef2b6b51?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    )),
                child: Stack(
                  children: [
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
                          scale: selected == index ? 1 : 0,
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
