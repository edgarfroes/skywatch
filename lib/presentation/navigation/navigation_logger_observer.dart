import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skywatch/domain/services/logger_service.dart';

class NavigationLoggerObserver extends AutoRouterObserver {
  NavigationLoggerObserver({
    required this.logger,
  });

  final LoggerService logger;

  @override
  void didPush(Route route, Route? previousRoute) {
    logger.info(
      'Navigated to screen ${route.settings.name}${route.settings.arguments != null ? '\nArguments: ${route.settings.arguments}' : ''}',
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logger.info(
      'Navigated to Tab ${route.name}',
    );
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logger.info('Navigated to Tab ${route.name}');
  }
}
