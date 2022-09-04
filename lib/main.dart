import 'package:egao/pages/detail.dart';
import 'package:egao/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(EgaoApp());
}

class EgaoApp extends StatelessWidget {
  EgaoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'egao box',
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePageView();
        },
      ),
      GoRoute(
        path: '/detail/:id',
        builder: (BuildContext context, GoRouterState state) {
          var params = state.params['id'] ?? '';
          return DetailPageView(id: params);
        },
      ),
    ],
  );
}
