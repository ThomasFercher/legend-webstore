import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/drawers/legend_drawer.dart';
import 'package:legend_design_core/layout/drawers/legend_drawer_info.dart';
import 'package:legend_design_core/layout/drawers/legend_drawer_provider.dart';
import 'package:legend_design_core/layout/drawers/menu_drawer.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/sectionNavigation/section_navigation.dart';
import 'package:legend_design_core/layout/sections/section.dart';
import 'package:legend_design_core/router/router_provider.dart';
import 'package:legend_design_core/router/routes/section_provider.dart';
import 'package:legend_design_core/router/routes/section_route_info.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:provider/provider.dart';
import 'fixed/appBar.dart/fixed_appbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'fixed/bottomBar.dart/fixed_bottom_bar.dart';
import 'fixed/fixed_footer.dart';
import 'fixed/sider/fixed_sider.dart';
import '../typography/legend_text.dart';
import '../typography/typography.dart';

class LegendScaffold extends StatefulWidget {
  final LayoutType? layoutType;
  final String pageName;
  final Function(BuildContext context)? onActionButtonPressed;
  final WidgetBuilder? siderBuilder;
  final WidgetBuilder? appBarBuilder;
  final bool? showSiderMenu;
  final bool? showSiderSubMenu;
  final bool? showAppBarMenu;
  late final bool singlePage;
  late final List<Widget> children;
  late final WidgetBuilder contentBuilder;
  late final FixedFooter? customFooter;
  final double? verticalChildrenSpacing;
  late final bool isUnderlyingRoute;

  LegendScaffold({
    required this.pageName,
    this.layoutType,
    this.onActionButtonPressed,
    this.siderBuilder,
    this.showSiderMenu,
    this.showAppBarMenu,
    this.appBarBuilder,
    this.showSiderSubMenu,
    WidgetBuilder? contentBuilder,
    List<Widget>? children,
    bool? singlePage,
    Key? key,
    this.customFooter,
    this.verticalChildrenSpacing,
    bool? isUnderlyingRoute,
  }) : super(key: key) {
    this.singlePage = singlePage ?? false;
    this.children = children ?? [];
    this.contentBuilder = contentBuilder ?? (f) => Container();
    this.isUnderlyingRoute = isUnderlyingRoute ?? false;
  }

  @override
  _LegendScaffoldState createState() => _LegendScaffoldState();
}

class _LegendScaffoldState extends State<LegendScaffold> {
  List<SectionRouteInfo>? sections;

  late ScrollController controller;

  late bool showSettings;

  @override
  void initState() {
    super.initState();

    showSettings = false;
    controller = ScrollController(
      initialScrollOffset: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    sections = SectionProvider.of(context)?.sections;

    return SizeProvider(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SectionNavigation(
        sections: sections,
        onNavigate: (section) {
          // Jump to Section

          if (sections != null) {
            SectionRouteInfo s = sections!.singleWhere(
              (element) => element.name == section.name,
              orElse: () {
                return sections!.first;
              },
            );
            if (s.key != null && s.key?.currentContext != null) {
              Scrollable.ensureVisible(
                s.key!.currentContext!,
                curve: Curves.easeInOut,
                duration: Duration(
                  milliseconds: 400,
                ),
              );
            }
          }
        },
        child: Builder(
          builder: (context) {
            if (kIsWeb) {
              return materialLayout(context);
            } else if (Platform.isIOS || Platform.isMacOS) {
              return cupertinoLayout(context);
            } else {
              return materialLayout(context);
            }
          },
        ),
      ),
    );
  }

  Widget cupertinoLayout(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(),
    );
  }

  Widget getSider(ScreenSize screenSize, BuildContext context) {
    if (widget.layoutType == LayoutType.FixedSider) {
      return FixedSider(
        showMenu: true,
        builder: widget.siderBuilder,
      );
    } else if (widget.layoutType == LayoutType.FixedHeaderSider &&
        screenSize != ScreenSize.Small) {
      return FixedSider(
        builder: widget.siderBuilder,
        showMenu: widget.showSiderMenu,
        showSubMenu: widget.showSiderSubMenu,
        showSectionMenu: true,
      );
    } else {
      return Container();
    }
  }

  Widget getFooter(double height, BuildContext context) {
    return LayoutProvider.of(context)?.globalFooter ?? Container();
  }

  Widget getHeader(BuildContext context) {
    switch (widget.layoutType) {
      case LayoutType.FixedHeaderSider:
        return FixedAppBar(
          showMenu: SizeProvider.of(context).isMobile == false
              ? widget.showAppBarMenu
              : false,
          builder: widget.appBarBuilder,
          pcontext: context,
          layoutType: widget.layoutType,
          onActionPressed: (i) {
            switch (i) {
              case 0:
                Provider.of<LegendDrawerProvider>(context, listen: false)
                    .showDrawer('/settings');
                break;
              default:
            }
          },
        );
      case LayoutType.FixedHeader:
        return FixedAppBar(
          builder: widget.appBarBuilder,
          showMenu: SizeProvider.of(context).isMobile == false
              ? widget.showAppBarMenu
              : false,
          pcontext: context,
          layoutType: widget.layoutType,
          onActionPressed: (i) {
            switch (i) {
              case 0:
                Provider.of<LegendDrawerProvider>(context, listen: false)
                    .showDrawer('/settings');
                break;
              default:
            }
          },
        );
      default:
        return SliverToBoxAdapter(
          child: Container(),
        );
    }
  }

  Widget getActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        widget.onActionButtonPressed!(context);
      },
    );
  }

  Widget materialLayout(BuildContext context) {
    SizeProvider sizeProvider = SizeProvider.of(context);
    ScreenSize screenSize = sizeProvider.screenSize;

    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    sizeProvider.titleWidth = SizeProvider.calcTextSize(
          'Legend Design',
          theme.typography.h6.copyWith(
            color: theme.colors.secondaryColor,
            letterSpacing: 0.1,
          ),
        ).width +
        26.0 +
        48.0;

    double maxHeight = SizeProvider.of(context).height -
        theme.sizing.appBarSizing.appBarHeight;

    // TODO Improve
    List<Widget> a = getChildren(context);
    List<Widget> children = List.of(
      a.map(
        (c) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.sizing.contentPadding,
              vertical: widget.verticalChildrenSpacing ?? 0 / 2,
            ),
            child: c,
          );
        },
      ),
    );
    double? footerheight;
    if (!sizeProvider.isMobile) {
      footerheight = 120;
    }

    return Stack(
      children: [
        Scaffold(
          endDrawer: MenuDrawer(),
          bottomNavigationBar: SizeProvider.of(context).isMobile
              ? FixedBottomBar(
                  colors: theme.bottomBarColors,
                  sizing: theme.bottomBarStyle,
                )
              : null,
          endDrawerEnableOpenDragGesture: false,
          floatingActionButton: widget.onActionButtonPressed != null
              ? Builder(
                  builder: (context) {
                    return getActionButton(context);
                  },
                )
              : null,
          body: Stack(
            children: [
              Row(
                children: [
                  getSider(screenSize, context),
                  Expanded(
                    child: CustomScrollView(
                      controller: controller,
                      slivers: [
                        getHeader(context),
                        if (widget.children.isEmpty)
                          SliverToBoxAdapter(
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              double space = maxHeight -
                                  (footerheight ?? 0) -
                                  theme.sizing.contentPadding * 2;

                              if (SizeProvider.of(context).isMobile) {
                                space -= (theme.bottomBarStyle?.height ?? 0) +
                                    (theme.bottomBarStyle?.margin.vertical ??
                                        0);
                              }

                              return Column(
                                children: [
                                  Container(
                                    color: theme.colors.scaffoldBackgroundColor,
                                    padding: EdgeInsets.all(
                                      theme.sizing.contentPadding,
                                    ),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: space,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (widget.isUnderlyingRoute &&
                                              widget.layoutType !=
                                                  LayoutType.FixedHeaderSider &&
                                              widget.layoutType !=
                                                  LayoutType.FixedHeaderSider)
                                            Container(
                                              height: SizeProvider.of(context)
                                                      .height -
                                                  80,
                                              width: 36,
                                              alignment: Alignment.center,
                                              child: LegendAnimatedIcon(
                                                icon: Icons.arrow_left,
                                                theme: LegendAnimtedIconTheme(
                                                    enabled: Colors.black87,
                                                    disabled: Colors.black26),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          Expanded(
                                            child: Builder(
                                              builder: widget.contentBuilder,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (footerheight != null)
                                    getFooter(footerheight, context),
                                ],
                              );
                            }),
                          )
                        else
                          SliverToBoxAdapter(
                            child: Container(
                              color: theme.colors.scaffoldBackgroundColor,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (widget.isUnderlyingRoute &&
                                          widget.layoutType !=
                                              LayoutType.FixedHeaderSider &&
                                          widget.layoutType !=
                                              LayoutType.FixedHeaderSider)
                                        Container(
                                          height:
                                              SizeProvider.of(context).height -
                                                  80,
                                          width: 36,
                                          alignment: Alignment.center,
                                          child: LegendAnimatedIcon(
                                            icon: Icons.arrow_left,
                                            theme: LegendAnimtedIconTheme(
                                                enabled: Colors.black87,
                                                disabled: Colors.black26),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: children,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  getFooter(120, context)
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if ((widget.layoutType == LayoutType.FixedSider ||
                      widget.layoutType == LayoutType.FixedHeaderSider) &&
                  !theme.isMobile)
                Positioned(
                  left: theme.appBarSizing.contentPadding.horizontal,
                  top: theme.appBarSizing.contentPadding.top,
                  child: Material(
                    color: Colors.transparent,
                    child: Hero(
                      tag: ValueKey('title'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: theme.appBarSizing.appBarHeight,
                            width: theme.appBarSizing.appBarHeight - 12,
                            margin: EdgeInsets.only(
                              right: 16.0,
                              left: 8,
                            ),
                            child:
                                LayoutProvider.of(context)?.logo ?? Container(),
                          ),
                          Container(
                            height: theme.appBarSizing.appBarHeight,
                            alignment: Alignment.center,
                            child: LegendText(
                              text: 'Legend Design',
                              textStyle: theme.typography.h6.copyWith(
                                color: theme.colors.appBarColors.foreground,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        getDrawer(context),
      ],
    );
  }

  Widget getDrawer(BuildContext context) {
    List<LegendDrawerRoute> routes = Provider.of<LegendDrawerProvider>(context)
        .drawerRoutes
        .cast<LegendDrawerRoute>();
    for (final LegendDrawerRoute route in routes) {
      if (route.visible) {
        return LegendDrawer(
          route: route,
          isMobile: SizeProvider.of(context).isMobile,
        );
      }
    }
    return Container();
  }

  List<Widget> getChildren(BuildContext context) {
    List<Widget> childs = [];

    for (final element in widget.children) {
      Widget w;
      if (element is Section) {
        Section s = element;
        GlobalKey key = GlobalKey();
        if (sections != null) {
          SectionRouteInfo se = sections!.singleWhere(
            (element) => element.name == s.name,
            orElse: () {
              return sections!.last;
            },
          );
          int i = sections!.indexOf(se);
          sections![i] = SectionRouteInfo(name: se.name, key: key);
        }

        w = Container(
          key: key,
          child: s,
        );
      } else {
        w = element;
      }
      childs.add(w);
    }

    return childs;
  }
}
