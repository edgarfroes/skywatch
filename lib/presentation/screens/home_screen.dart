import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      homeIndex: 0,
      routes: const [
        WeatherForecastTabRoute(),
        UploadVideoTabRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              label: context.l10n.bottom_navbar_view_weather,
              icon: const Icon(Icons.cloudy_snowing),
            ),
            BottomNavigationBarItem(
              label: context.l10n.bottom_navbar_upload_video,
              icon: const Icon(Icons.upload),
            ),
          ],
        );
      },
    );
  }
}
