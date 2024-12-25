import 'package:flutter/material.dart';
import 'package:task/core/di/di.dart';
import 'package:task/features/add_task/add_task_view.dart';
import 'package:task/features/home/home_page_view.dart';
import 'package:task/features/login/presentation/login_view.dart';
import 'package:task/features/signup/presentation/signup_view.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => HomePageView());
      case Routes.addTask:
        return MaterialPageRoute(builder: (_) => AddTaskView());
      case Routes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signUp:
        initSignupModule();
        return MaterialPageRoute(builder: (_) => SignupView());

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
  static const String addTask = '/addTask';
  static const String login = '/';
  static const String signUp = '/signUp';
  static const String homePage = '/homePage';
}
