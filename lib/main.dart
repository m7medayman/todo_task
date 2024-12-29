import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/rout_manager/rout_manager.dart';
import 'package:task/core/theme_manager/theme_manager.dart';
import 'package:task/features/add_task/presentation/add_task_view.dart';
import 'package:task/features/home/presentation/home_page_view.dart';
import 'package:task/features/login/presentation/login_view.dart';
import 'package:task/features/signup/presentation/signup_view.dart';
import 'package:task/features/task_Details/task_datails_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final designSize = isPortrait ? const Size(375, 812) : const Size(600, 300);
    return MediaQuery(
      data: MediaQueryData.fromView(WidgetsBinding.instance.window)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          builder: (_, chiled) {
            return MaterialApp(
              onGenerateRoute: RouteManager.generateRoute,
              initialRoute: Routes.login,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: getTheme(context),
            );
          }),
    );
  }
}

class DesignSizeHelper {
  static Size getDesignSize(BuildContext context) {
    // Get screen width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Check if the device is in portrait or landscape mode
    bool isPortrait = height > width;

    // Define design sizes based on screen width and height ranges
    if (width <= 360) {
      // Small devices (e.g., small phones)
      return isPortrait ? const Size(320, 568) : const Size(568, 320);
    } else if (width <= 480) {
      // Medium devices (e.g., medium phones)
      print("pppppppppppppp");
      return isPortrait ? const Size(375, 812) : const Size(600, 375);
    } else if (width <= 720) {
      // Larger devices (e.g., larger phones or small tablets)
      return isPortrait ? const Size(414, 736) : const Size(736, 414);
    } else if (width <= 1080) {
      // Tablets or small desktops
      return isPortrait ? const Size(768, 1024) : const Size(1024, 768);
    } else {
      // Large tablets or desktops
      return isPortrait ? const Size(1080, 1920) : const Size(1920, 1080);
    }
  }
}
