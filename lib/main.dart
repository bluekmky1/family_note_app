import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        routerConfig: ref.watch(appRouterProvider).router,
        title: '좀만 더 잘래',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Pretendard',
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 155, 155, 155),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      );
}
