import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/answers/question_view.dart';
import '../ui/auth/sign_in/sign_in_view.dart';
import '../ui/auth/sign_up/sign_up_view.dart';
import '../ui/family_rooms/family_rooms_view.dart';
import '../ui/home/home_view.dart';
import '../ui/recruit/recruit_view.dart';
import 'app_router_interceptor.dart';
import 'redirect_notifier.dart';
import 'routes.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((ProviderRef<AppRouter> ref) => AppRouter(
          appRouterInterceptor: AppRouterInterceptor(ref: ref),
          refreshListenable: ref.read(redirectNotifierProvider),
        ));

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter({
    required Listenable refreshListenable,
    required AppRouterInterceptor appRouterInterceptor,
  })  : _appRouterInterceptor = appRouterInterceptor,
        _refreshListenable = refreshListenable;

  final AppRouterInterceptor _appRouterInterceptor;
  final Listenable _refreshListenable;

  // 라우트의 이동마다 호출됩니다.
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) =>
      _appRouterInterceptor.redirect(context, state);

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.familyRooms.name,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    refreshListenable: _refreshListenable,
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
          name: Routes.familyRooms.name,
          path: Routes.familyRooms.path,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<dynamic>(
                child: FamilyRoomsView(),
              ),
          routes: <RouteBase>[
            GoRoute(
              name: Routes.recruit.name,
              path: Routes.recruit.path,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<dynamic>(
                child: RecruitView(),
              ),
            ),
            GoRoute(
              path: Routes.home.path,
              name: Routes.home.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  NoTransitionPage<dynamic>(
                child: HomeView(
                  familyId: state.pathParameters['familyId'] ?? '',
                ),
              ),
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.question.name,
                  path: Routes.question.path,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      NoTransitionPage<dynamic>(
                    child: QuestionView(
                        familyId: state.pathParameters['familyId'] ?? '',
                        question: state.pathParameters['question'] ?? '',
                        questionId: state.pathParameters['questionId'] ?? '',
                        createdAt: state.pathParameters['createdAt'] ?? ','),
                  ),
                ),
              ],
            ),
          ]),
    ],
  );

  GoRouter get router => _router;
}
