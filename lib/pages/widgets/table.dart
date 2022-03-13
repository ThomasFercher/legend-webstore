import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_widgets/datadisplay/table/legendRowValue.dart';
import 'package:legend_design_widgets/datadisplay/table/legendTable.dart';
import 'package:legend_design_widgets/datadisplay/table/legendTableCell.dart';
import 'package:provider/src/provider.dart';

class TablePage extends StatelessWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    return LegendScaffold(
      pageName: 'Table',
      layoutType: LayoutType.FixedHeader,
      showSiderMenu: false,
      isUnderlyingRoute: true,
      contentBuilder: (context, s) {
        return Column(
          children: [
            LegendTable(
              header: "Test Table",
              rowHeight: 56,
              columnTypes: [
                LegendTableValueType.TEXT,
                LegendTableValueType.TAG,
                LegendTableValueType.ACTION,
              ],
              values: [
                LegendRowValue(
                  fields: [
                    "test",
                    [
                      ["Trottl", Colors.red],
                      ["Lappen", Colors.blue],
                    ],
                    "delete"
                  ],
                  actionFunction: () {
                    print("hello");
                  },
                ),
                LegendRowValue(
                  fields: [
                    "asd",
                    [
                      ["Developer", Colors.orange],
                      ["Coolman", Colors.green],
                    ],
                    "delete"
                  ],
                  actionFunction: () {
                    print("hello");
                  },
                ),
                LegendRowValue(
                  fields: [
                    "test",
                    [
                      ["Nice", Colors.brown],
                      ["Cool", Colors.purple],
                    ],
                    "delete"
                  ],
                  actionFunction: () {
                    print("hello");
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
