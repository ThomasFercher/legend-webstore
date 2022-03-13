import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_widgets/datadisplay/card/legendCard.dart';
import 'package:legend_design_widgets/datadisplay/stars/legend_stars.dart';
import 'package:provider/src/provider.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    return LegendScaffold(
      pageName: 'Rating',
      layoutType: LayoutType.FixedHeader,
      showSiderMenu: false,
      isUnderlyingRoute: true,
      contentBuilder: (context, s) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StarRating(
                  onRatingChanged: (i) => print(i),
                  amount: 5,
                  color: theme.colors.primaryColor,
                  size: 35,
                  spacing: 4,
                ),
                StarRating(
                  onRatingChanged: (i) => print(i),
                  amount: 3,
                  color: Colors.amber,
                  size: 35,
                  spacing: 10,
                ),
                LegendCard(
                  children: [
                    StarRating(
                      onRatingChanged: (i) => print(i),
                      amount: 10,
                      color: Colors.red,
                      size: 35,
                      spacing: 4,
                    )
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }
}
