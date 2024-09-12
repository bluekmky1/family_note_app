import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/auth/sign_in/sign_in_view.dart';
import '../ui/auth/sign_up/sign_up_view.dart';
import '../ui/home/home_view.dart';
import '../ui/recruit/recruit_view.dart';
import 'app_router_interceptor.dart';
import 'routes.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((ProviderRef<AppRouter> ref) => AppRouter(
          appRouterInterceptor: AppRouterInterceptor(ref: ref),
        ));

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter({
    required AppRouterInterceptor appRouterInterceptor,
  }) : _appRouterInterceptor = appRouterInterceptor;
  final AppRouterInterceptor _appRouterInterceptor;

  // 라우트의 이동마다 호출됩니다.
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) =>
      _appRouterInterceptor.redirect(context, state);

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.home.name,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    errorBuilder: (BuildContext context, GoRouterState state) => const Scaffold(
      body: Center(
        child: Text('Internal Error'),
      ),
    ),
    redirect: _redirect,
    routes: <RouteBase>[
      GoRoute(
          path: Routes.auth.path,
          name: Routes.auth.name,
          redirect: (BuildContext context, GoRouterState state) {
            if (state.fullPath == null || state.fullPath == Routes.auth.path) {
              return Routes.signIn.name;
            }
            return null;
          },
          routes: <RouteBase>[
            GoRoute(
                name: Routes.signIn.name,
                path: Routes.signIn.path,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage<dynamic>(
                      child: SignInView(),
                    ),
                routes: <RouteBase>[
                  GoRoute(
                    name: Routes.signUp.name,
                    path: Routes.signUp.path,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        const NoTransitionPage<dynamic>(
                      child: SignUpView(),
                    ),
                  ),
                ]),
          ]),
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: HomeView(),
        ),
      ),
      GoRoute(
        name: Routes.recruit.name,
        path: Routes.recruit.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: RecruitView(),
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}
