import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/home/home_view.dart';
import 'routes.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((ProviderRef<AppRouter> ref) => AppRouter());

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter();

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.home.path,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    errorBuilder: (BuildContext context, GoRouterState state) =>
        const Scaffold(),
    routes: <RouteBase>[
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: HomeView(),
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}
