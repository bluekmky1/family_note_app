import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../service/app/app_service.dart';
import '../service/app/app_state.dart';
import 'routes.dart';

// redirect 여부 및 redirect location 를 결정하는 역할을 수행합니다.
class AppRouterInterceptor {
  final Ref _ref;

  const AppRouterInterceptor({
    required Ref<Object?> ref,
  }) : _ref = ref;

  // 라우트의 이동마다 호출됩니다.
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final bool isSignedIn = _ref
        .read(appServiceProvider.select((AppState value) => value.isSignedIn));

    final bool hasFamily = _ref
        .watch(appServiceProvider.select((AppState value) => value.hasFamily));
    // final bool hasUserInfo = _ref.read(
    //   myInfoServiceProvider.select((MyInfoState value) => value.hasUserInfo),
    // );
    // final bool isNeedForedUPdate = _ref.read(
    //   appServiceProvider.select((AppState value) => value.isNeedUpdate),
    // );

    // final bool isPermissionTrue = _ref.read(
    //   myInfoServiceProvider
    //       .select((MyInfoState value) => value.isPermissionTrue),
    // );

    if (!isSignedIn) {
      // sign in 으로 가야만 하는 상태입니다.
      if (state.fullPath?.startsWith(Routes.auth.name) == false) {
        return Routes.signIn.name;
      }
    }

    // 로그인이 되었고 가족 모집이 완료되지 않은 상태
    if (isSignedIn) {
      if (!hasFamily) {
        return Routes.recruit.name;
      }
    }

    return null;

    // // 현재 위치가 아직도 auth 관련 페이지에 있다면
    // // 즉시 홈화면으로 리다이렉트 해줍니다.
    // if (state.fullPath != null &&
    //     state.fullPath!.startsWith(Routes.auth.name)) {
    //   return Routes.home.name;
    // }
    // return null;
  }
}
