import 'package:clean_architecture/app/navigation/app_router.dart';
import 'package:clean_architecture/app/ui/screens/main/main_screen.dart';
import 'package:clean_architecture/app/ui/splash/splash_screen.dart';
import 'package:clean_architecture/app/ui/splash/splash_screen_viewmodel.dart';
import 'package:go_router/go_router.dart';

class AppRouterConfig {
  late final GoRouter router =
      GoRouter(routes: _routes, initialLocation: AppRouter.root);

  void dispose() {}

  late final _routes = <RouteBase>[
    GoRoute(
        path: "/",
        name: AppRouter.root,
        builder: (context, state) =>
            SplashScreen(viewModel: SplashScreenViewmodel())),
    GoRoute(
        path: "/main",
        name: AppRouter.main,
        builder: (context, state) => const MainScreen())
  ];
}
