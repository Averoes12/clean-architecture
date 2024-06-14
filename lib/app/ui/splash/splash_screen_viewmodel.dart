import 'package:clean_architecture/app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenViewmodel {
  void goToMainScreen(BuildContext context) {
    context.go(AppRouter.main);
  }
}
