import 'route_info.dart';

class Routes {
  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/home',
    path: '/home',
  );

  // 알람 등록 페이지
  static const RouteInfo alarm = RouteInfo(
    name: '/home/alarm/:busStopId',
    path: 'alarm/:busStopId',
  );
}
