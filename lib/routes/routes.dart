import 'route_info.dart';

class Routes {
  // auth 기본
  static const RouteInfo auth = RouteInfo(
    name: '/auth',
    path: '/auth',
  );

  // 로그인 페이지
  static const RouteInfo signIn = RouteInfo(
    name: '/auth/sign-in',
    path: 'sign-in',
  );

  // 회원가입 페이지
  static const RouteInfo signUp = RouteInfo(
    name: 'auth/sign-in/sign-up',
    path: 'sign-up',
  );

  // 가족방 선택 페이지
  static const RouteInfo familyRooms = RouteInfo(
    name: '/family-rooms',
    path: '/family-rooms',
  );

  // 가족 구성원 모집 페이지
  static const RouteInfo recruit = RouteInfo(
    name: '/family-rooms/recruit',
    path: 'recruit',
  );

  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/family-rooms/home/:familyId',
    path: 'home/:familyId',
  );

  // 답변 작성 및 보기 페이지
  static const RouteInfo question = RouteInfo(
    name:
        '/family-rooms/home/:familyId/question/:questionId/:question/:createdAt',
    path: 'question/:questionId/:question/:createdAt',
  );
}
