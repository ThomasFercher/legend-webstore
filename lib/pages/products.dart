import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webstore/customwidgets/datadisplay/table/legendRowValue.dart';
import 'package:webstore/customwidgets/datadisplay/table/legendTable.dart';
import 'package:webstore/customwidgets/datadisplay/table/legendTableCell.dart';
import 'package:webstore/customwidgets/legendButton/legendButtonStyle.dart';
import 'package:webstore/customwidgets/legendButton/legendButton.dart';
import 'package:webstore/customwidgets/typography/legendText.dart';
import 'package:webstore/styles/typography.dart';
import '../customwidgets/layout/fixed/fixedAppBar.dart';
import '../customwidgets/layout/legendScaffold.dart';
import '../styles/layoutType.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LegendScaffold(
      contentBuilder: (context) {
        return Container(
          height: 1000,
          child: Column(
            children: [
              LegendButton(
                text: LegendText(text: "test", textStyle: LegendTextStyle.h6()),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                onPressed: () => {},
                style: LegendButtonStyle.gradient(
                  [
                    Colors.red[200]!,
                    Colors.redAccent,
                  ],
                ),
              ),
              LegendTable(
                columnTypes: [
                  LegendTableValueType.TEXT,
                  LegendTableValueType.TEXT,
                  LegendTableValueType.ACTION,
                ],
                values: [
                  LegendRowValue(
                      fields: ["test", "tata", "delete"],
                      actionFunction: () {
                        print("hello");
                      }),
                  LegendRowValue(
                      fields: ["test", "tata", "delete"],
                      actionFunction: () {
                        print("hello");
                      }),
                  LegendRowValue(
                      fields: ["test", "tata", "delete"],
                      actionFunction: () {
                        print("hello");
                      }),
                ],
              ),
            ],
          ),
        );
      },
      pageName: "Products",
      layoutType: LayoutType.FixedHeader,
    );
  }
}
