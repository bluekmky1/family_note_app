import 'route_info.dart';

class Routes {
  // // auth 기본
  // static const RouteInfo auth = RouteInfo(
  //   name: '/auth',
  //   path: '/auth',
  // );

  // 로그인 페이지
  static const RouteInfo signIn = RouteInfo(
    name: '/sign-in',
    path: '/sign-in',
  );

  // 회원가입 페이지
  static const RouteInfo signUp = RouteInfo(
    name: '/sign-up',
    path: '/sign-up',
  );

  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/home',
    path: '/home',
  );

  // 가족 구성원 모집 페이지
  static const RouteInfo recruit = RouteInfo(
    name: '/recruit',
    path: '/recruit',
  );
}
