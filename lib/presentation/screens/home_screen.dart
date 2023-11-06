import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skywatch/app_router.dart';

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
    // return Scaffold(
    //   body:
    //   SafeArea(
    //     child: Container(
    //       alignment: Alignment.center,
    //       padding: const EdgeInsets.symmetric(vertical: 50),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.max,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           const Spacer(),
    //           SvgPicture.asset(
    //             Assets.icon.iconSvg.path,
    //             width: MediaQuery.of(context).size.width * 0.6,
    //           ),
    //           const Spacer(),
    //           Column(
    //             children: [
    //               RoundedButton(
    //                 label: 'Upload video',
    //                 icon: Icons.upload,
    //                 onPressed: () {
    //                   //
    //                 },
    //               ),
    //               const Gap(20),
    //               RoundedButton(
    //                 label: 'Upload video',
    //                 onPressed: () {
    //                   //
    //                 },
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

// class RoundedButton extends StatelessWidget {
//   const RoundedButton({
//     super.key,
//     required this.onPressed,
//     required this.label,
//     this.icon,
//   });

//   final String label;
//   final VoidCallback onPressed;
//   final IconData? icon;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Material(
//       borderRadius: BorderRadius.circular(100),
//       color: theme.colorScheme.primary,
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onPressed,
//         child: Padding(
//           padding: EdgeInsets.only(
//             left: icon != null ? 10 : 30,
//             right: 30,
//             top: 10,
//             bottom: 10,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (icon != null) ...[
//                 Icon(
//                   icon!,
//                   color: theme.colorScheme.onPrimary,
//                   size: 20,
//                 ),
//                 const Gap(10),
//               ],
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: theme.colorScheme.onPrimary,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
