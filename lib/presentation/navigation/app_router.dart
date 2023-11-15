import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/presentation/screens/ask_for_photos_permission_screen.dart';
import 'package:skywatch/presentation/screens/country_selection_screen.dart';
import 'package:skywatch/presentation/screens/home_screen.dart';
import 'package:skywatch/presentation/screens/splash_screen.dart';
import 'package:skywatch/presentation/services/photos_permission_service.dart';
import 'package:skywatch/presentation/tabs/upload_video_tab.dart';
import 'package:skywatch/presentation/tabs/weather_forecast_tab.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          initial: true,
          fullscreenDialog: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: HomeRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
          children: [
            AutoRoute(page: WeatherForecastTabRoute.page),
            AutoRoute(page: UploadVideoTabRoute.page),
          ],
        ),
        AutoRoute(page: CountrySelectionRoute.page),
        AutoRoute(page: AskForPhotosPermissionRoute.page),
      ];

  Future<void> goToHomeScreen() async => await replace(const HomeRoute());

  Future<void> goToUploadVideoTab() async =>
      await replace(const UploadVideoTabRoute());

  Future<PermissionStatus?> goToAskForPhotosPermissionScreen({
    bool popWhenGranted = false,
  }) =>
      _pushWithResult(
        AskForPhotosPermissionRoute(
          popWhenGranted: popWhenGranted,
        ),
      );

  Future<Country?> openCountrySelectionScreen({
    Country? selectedCountry,
  }) =>
      _pushWithResult(
        CountrySelectionRoute(
          selectedCountry: selectedCountry,
        ),
      );

  Future<T?> _pushWithResult<T>(PageRouteInfo<dynamic> route) async {
    final result = await push(route);

    if (result is! T) {
      return null;
    }

    return result;
  }
}

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());

extension RouteDataExtension on RouteData {
  String? get pageTitle => _pageTitle();

  String? _pageTitle() {
    if (args == null ||
        args is! Map<String, dynamic> ||
        (args as Map<String, dynamic>)['pageTitle'] is! String) {
      return null;
    }

    return (args as Map<String, dynamic>)['pageTitle'];
  }
}
