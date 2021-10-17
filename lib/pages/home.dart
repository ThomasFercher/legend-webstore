import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:webstore/customwidgets/input/selectBar/legendSelectBar.dart';
import 'package:webstore/customwidgets/input/selectBar/legendSelectOption.dart';
import 'package:webstore/customwidgets/layout/sections/section.dart';
import 'package:webstore/customwidgets/legendButton/legendButtonStyle.dart';
import 'package:webstore/customwidgets/modals/legendAlert.dart';
import 'package:webstore/customwidgets/modals/legendPopups.dart';
import 'package:webstore/styles/theming/legendTheme.dart';
import '../customwidgets/modals/legendBottomSheet.dart';
import '../customwidgets/legendButton/legendButton.dart';
import '../customwidgets/layout/legendScaffold.dart';
import '../customwidgets/modals/modal.dart';
import '../customwidgets/typography/legendText.dart';
import '../styles/layouts/layoutType.dart';
import '../customwidgets/typography/typography.dart';

class Home extends StatelessWidget {
  const Home();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    LegendTheme theme = Provider.of<LegendTheme>(context);
    return LegendScaffold(
      contentBuilder: (context) {
        return Column(
          children: [
            Section(
              verticalSpacing: 12,
              header: "What is Legend Design?",
              children: [
                LegendText(
                  text: "Legend Design aims to provide all basic needs for developing  Cross-Plattform Applications. These include Routing, Colors, Layouts, Sizing and many other little things. " +
                      "Using the Legend Design package enables developers to write clean code without much boilerplate which is suited for every platform. " +
                      "On top of this Legend Design Custom Widgets on most of the functionality can be used on its own, so you dont get forced to use everything provided. ",
                  textStyle: LegendTextStyle.p(),
                ),
              ],
            ),
          ],
        );
      },
      layoutType: LayoutType.FixedHeader,
      pageName: "Home",
      onActionButtonPressed: (context) {
        LegendPopups.showLegendModal(
          context: context,
          modal: Modal(
            content: Text("test"),
            onConfirm: () => {},
            onCancle: () => {},
            height: 400,
            width: 400,
          ),
        );
      },
    );
  }
}
