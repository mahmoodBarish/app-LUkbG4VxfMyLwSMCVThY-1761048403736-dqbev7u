import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/messanger_chats.dart';
import 'screens/messanger_swipe_actions.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/messanger_chats',
  routes: <RouteBase>[
    GoRoute(
      path: '/messanger_chats',
      builder: (BuildContext context, GoRouterState state) {
        return const MessangerChats();
      },
    ),
    GoRoute(
      path: '/messanger_swipe_actions',
      builder: (BuildContext context, GoRouterState state) {
        return const MessangerSwipeActions();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
