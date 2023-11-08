import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
          items: const [
            BottomNavigationBarItem(
              label: 'Weather',
              icon: Icon(Icons.cloudy_snowing),
            ),
            BottomNavigationBarItem(
              label: 'Upload Video',
              icon: Icon(Icons.upload),
            ),
          ],
        );
      },
    );
  }
}
