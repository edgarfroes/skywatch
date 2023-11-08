import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';

class NavigationLoggerObserver extends AutoRouterObserver {
  NavigationLoggerObserver({
    required this.loggerRepository,
  });

  final LoggerRepository loggerRepository;

  @override
  void didPush(Route route, Route? previousRoute) {
    loggerRepository.info(
      'Navigated to screen ${route.settings.name}${route.settings.arguments != null ? '\nArguments: ${route.settings.arguments}' : ''}',
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    loggerRepository.info(
      'Navigated to Tab ${route.name}',
    );
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    loggerRepository.info('Navigated to Tab ${route.name}');
  }
}
