import 'package:flutter/material.dart';
import 'package:webstore/customwidgets/layout/grid/legendGridSize.dart';
import 'package:webstore/customwidgets/layout/sections/sectionHeader.dart';
import 'package:webstore/customwidgets/typography/legendText.dart';
import 'package:webstore/styles/layoutType.dart';
import 'package:webstore/styles/sizeProvider.dart';
import 'package:webstore/styles/typography.dart';

class LegendGrid extends StatelessWidget {
  final List<Widget> children;
  final LegendGridSize sizes;
  final int? crossAxisCount;

  LegendGrid({
    required this.children,
    required this.sizes,
    this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    ScreenSize ss = SizeProvider.of(context).screenSize;

    LegendGridSizeInfo size;
    switch (ss) {
      case ScreenSize.Small:
        size = sizes.small;
        break;
      case ScreenSize.Medium:
        size = sizes.medium;
        break;
      case ScreenSize.Large:
        size = sizes.large;
        break;
      case ScreenSize.XXL:
        size = sizes.xxl;
        break;
      default:
        size = sizes.small;
        break;
    }

    return LayoutBuilder(builder: (context, constraints) {
      int count = size.count;
      double height = size.height;
      double singleChildWidth = constraints.maxWidth / count;
      int rows = (children.length / count).ceil();
      double aspectRatio = singleChildWidth / (height / rows);
      return Container(
        height: height,
        child: GridView.count(
          childAspectRatio: aspectRatio,
          crossAxisCount: count,
          children: children,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      );
    });
  }
}
