import 'package:dresscode/src/constants/metadata.dart';
import 'package:dresscode/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppInfos.appName,
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Quicksand',

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w300
          ),
          displayMedium: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w400
          ),
          displaySmall: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w400
          ),
          headlineLarge: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600
          ),
          titleLarge: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500
          ),
          titleMedium: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500
          ),
          titleSmall: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w400
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w400
          ),
          bodySmall: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w400
          ),
          labelLarge: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500
          ),
          labelMedium: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500
          ),
          labelSmall: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
