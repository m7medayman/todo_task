import 'package:flutter/material.dart';
import 'package:task/core/common/widget/qr_page.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/common/widget/status_flag.dart';
import 'package:task/core/di/di.dart';
import 'package:task/features/add_task/presentation/add_task_view.dart';
import 'package:task/core/domain/task_data.dart';
import 'package:task/features/home/presentation/home_page_view.dart';
import 'package:task/features/login/presentation/login_view.dart';
import 'package:task/features/signup/presentation/signup_view.dart';
import 'package:task/features/task_Details/task_datails_view.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.taskDetail:
        TaskData taskData = settings.arguments as TaskData;
        return MaterialPageRoute(
            builder: (_) => TaskDatailsView(
                  taskData: taskData,
                ));
      case Routes.homePage:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => HomePageView());
      case Routes.addTask:
        initAddMoudle();
        TaskData? taskData = settings.arguments as TaskData?;
        return MaterialPageRoute(
            builder: (_) => AddTaskView(
                  taskData: taskData,
                  // taskData: TaskData(
                  //     id: "id",
                  //     title: "title",
                  //     description: "description",
                  //     date: "20-30-40",
                  //     flagPoriorty: levelFlag.LOW,
                  //     status: ItemStatus.FINISHED
                  // ),
                ));
      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signUp:
        initSignupModule();
        return MaterialPageRoute(builder: (_) => SignupView());
      case Routes.qrPage:
        return MaterialPageRoute(builder: (_) => QRScannerPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

class Routes {
  static const String taskDetail = '/taskDetials';
  static const String addTask = '/addTask';
  static const String login = '/';
  static const String signUp = '/signUp';
  static const String homePage = '/homePage';
  static const String qrPage = '/qrPage';
}
