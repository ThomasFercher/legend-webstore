import 'package:flutter/widgets.dart';

class MyRouteInformationParser
    extends RouteInformationParser<List<RouteSettings>> {
  const MyRouteInformationParser() : super();

  @override
  Future<List<RouteSettings>> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return Future.value(
        [
          RouteSettings(
            name: '/',
          ),
        ],
      );
    }
    final routeSettings = uri.pathSegments
        .map((pathSegment) => RouteSettings(
              name: '/$pathSegment',
              arguments: pathSegment == uri.pathSegments.last
                  ? uri.queryParameters
                  : null,
            ))
        .toList();
    return Future.value(routeSettings);
  }

  @override
  RouteInformation? restoreRouteInformation(configuration) {
    final String name;
    final String arguments;
    if (configuration.isNotEmpty) {
      name = configuration.last.name ?? '';
      arguments = _restoreArguments(configuration.last);
    } else {
      name = '';
      arguments = '';
    }
    return RouteInformation(location: '$name$arguments');
  }

  String _restoreArguments(RouteSettings routeSettings) {
    if (routeSettings.name != '/recipe') return '';
    return '?id=${routeSettings.arguments}';
  }
}
