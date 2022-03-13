import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/styles/theming/colors/legend_color_palette.dart';
import 'package:legend_design_core/styles/theming/colors/legend_color_theme.dart';
import 'package:legend_design_core/styles/theming/colors/legend_colors.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_widgets/layout/grid/legendGrid.dart';
import 'package:legend_design_widgets/layout/grid/legendGridSize.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> border;
  late AnimationController controller;
  Color borderColor = Colors.transparent;
  LegendColorThemeType? themeType;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    border = ColorTween(
      begin: Colors.transparent,
      end: Colors.tealAccent,
    ).animate(new CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          borderColor = border.value ?? Colors.transparent;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();

    return Container(
      height: MediaQuery.of(context).size.height,
      color: theme.colors.background[1],
      width: 360,
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LegendText(
                  text: "Themes",
                  textStyle: theme.typography.h5.copyWith(
                    color: theme.colors.textColorLight,
                  ),
                ),
                LegendAnimatedIcon(
                  icon: Icons.close,
                  disableShadow: true,
                  theme: LegendAnimtedIconTheme(
                    enabled: theme.colors.selectionColor,
                    disabled: theme.colors.foreground[1],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: theme.colors.background[2],
          ),
          LegendGrid(
            margin: EdgeInsets.only(top: 8),
            width: 400,
            children: [
              InkWell(
                onTap: () {
                  theme.changeColorTheme(PaletteType.dark(), context);
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: themeType == LegendColorThemeType.DARK
                        ? Border.all(
                            color: theme.colors.primaryColor,
                            width: 2,
                          )
                        : null,
                    borderRadius: theme.sizing.borderRadius[0],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      theme.sizing.borderInset[1],
                    ),
                    decoration: BoxDecoration(
                      color: LegendColors.gray8,
                      borderRadius: theme.sizing.borderRadius[1],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 4,
                          bottom: 4,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: LegendColors.gray10,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 40,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: LegendColors.gray9,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              color: LegendColors.gray10,
                              border: Border.all(
                                width: 2,
                                color: LegendColors.gray9,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: LegendColors.gray11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  theme.changeColorTheme(PaletteType.light(), context);
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: themeType == LegendColorThemeType.LIGHT
                        ? Border.all(
                            color: theme.colors.primaryColor,
                            width: 2,
                          )
                        : null,
                    borderRadius: theme.sizing.borderRadius[0],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      theme.sizing.borderInset[1],
                    ),
                    decoration: BoxDecoration(
                      color: LegendColors.gray2,
                      borderRadius: theme.sizing.borderRadius[1],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 4,
                          bottom: 4,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: LegendColors.gray5,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 40,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: LegendColors.gray6,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              color: LegendColors.gray5,
                              border: Border.all(
                                width: 2,
                                color: LegendColors.gray6,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: LegendColors.gray7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeColorTheme(
                    PaletteType.custom(
                      i: 2,
                    ),
                    context,
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: themeType == LegendColorThemeType.LIGHT
                        ? Border.all(
                            color: theme.colors.primaryColor,
                            width: 2,
                          )
                        : null,
                    borderRadius: theme.sizing.borderRadius[0],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      theme.sizing.borderInset[1],
                    ),
                    decoration: BoxDecoration(
                      color: LegendColors.gray2,
                      borderRadius: theme.sizing.borderRadius[1],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 4,
                          bottom: 4,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: LegendColors.gray5,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 40,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: LegendColors.gray6,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              color: LegendColors.gray5,
                              border: Border.all(
                                width: 2,
                                color: LegendColors.gray6,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: LegendColors.gray7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            sizes: LegendGridSize(
              medium: LegendGridSizeInfo(2, 200),
              layoutDirection: LegendGridSizeDirection.DOWN,
            ),
          ),
        ],
      ),
    );
  }
}
