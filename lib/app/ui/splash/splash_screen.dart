import 'package:clean_architecture/app/ui/splash/splash_screen_viewmodel.dart';
import 'package:clean_architecture/library/resources/assets.dart';
import 'package:clean_architecture/library/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  final SplashScreenViewmodel viewModel;
  const SplashScreen({required this.viewModel, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        widget.viewModel.goToMainScreen(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SvgPicture.asset(
          AppIcons.imdbLogo,
          height: 200,
        ),
      ),
    );
  }
}
